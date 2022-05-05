# nginx-php-fpm

## Overview

This is a Dockerfile / image for Nginx and PHP-FPM

### Versioning
| Docker Tag | Git Release | Nginx Version | PHP Version | Alpine Version |
|-----|-------|-----|--------|--------|
| latest | Master Branch |1.18.0 | 8.0.13 | 3.13 |
| latest |  |1.20.2 | 8.0.13 | 3.14 |

## Quick Start

### Setup

1. Install hadolint, pre-commit package in local.

Login ECR
```
aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 746434807814.dkr.ecr.us-west-2.amazonaws.com
```

To pull from docker hub:
```
docker pull 746434807814.dkr.ecr.us-west-2.amazonaws.com/nginx-php-fpm:latest
```

### Running
To simply run the container:
```
sudo docker run -d 746434807814.dkr.ecr.us-west-2.amazonaws.com/nginx-php-fpm
```
