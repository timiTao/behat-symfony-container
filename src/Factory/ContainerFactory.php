<?php
/**
 * @author Tomasz Kunicki <kunicki.tomasz@gmail.com>
 */

namespace TimiTao\BehatSymfonyContainer\Factory;

use Psr\Container\ContainerInterface;
use Symfony\Component\Config\FileLocator;
use Symfony\Component\Config\Loader\DelegatingLoader;
use Symfony\Component\Config\Loader\LoaderResolver;
use Symfony\Component\DependencyInjection\ContainerBuilder;
use Symfony\Component\DependencyInjection\Loader\PhpFileLoader;
use Symfony\Component\DependencyInjection\Loader\XmlFileLoader;
use Symfony\Component\DependencyInjection\Loader\YamlFileLoader;
use TimiTao\BehatSymfonyContainer\Service\Container;

class ContainerFactory
{
    /**
     * @var string
     */
    private $basePath;

    /**
     * ContainerFactory constructor.
     * @param string $basePath
     */
    public function __construct($basePath)
    {
        $this->basePath = $basePath;
    }

    /**
     * @param array $files
     *
     * @return ContainerInterface
     */
    public function factory(array $files)
    {
        $container = $this->createContainer($files);
        $container->compile();

        return $container;
    }

    /**
     * @param array $files
     *
     * @return Container
     */
    private function createContainer(array $files)
    {
        $containerBuilder = new Container();
        $loader = $this->createLoader($containerBuilder);
        foreach ($files as $file) {
            $loader->load($file);
        }

        return $containerBuilder;
    }

    /**
     * @param ContainerBuilder $containerBuilder
     * @return DelegatingLoader
     */
    private function createLoader(ContainerBuilder $containerBuilder)
    {
        $fileLocator = new FileLocator([$this->basePath]);
        $loader = new DelegatingLoader(
            new LoaderResolver([
                new XmlFileLoader($containerBuilder, $fileLocator),
                new YamlFileLoader($containerBuilder, $fileLocator),
                new PhpFileLoader($containerBuilder, $fileLocator),
            ])
        );

        return $loader;
    }
}