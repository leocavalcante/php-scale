# PHP Scale

This project benchmarks 2 ways of scaling PHP in Kubernetes.


## PHP 1

```shell
make TARGET=php-1
```

| Replicas | CPU | Memory |
| --- | --- | --- |
| 12 | 500m | 500Mi |

## PHP 2

```shell
make TARGET=php-2
```

| Replicas | CPU | Memory |
| --- | --- | --- |
| 3 | 2 (2000m) | 2G |

At the end, both ways consumes 6 CPUs and 6G RAM, **but** PHP 1 is more horizontal, while PHP 2 is more vertical.

## Results

[Here](results)
