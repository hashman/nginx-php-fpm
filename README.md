# nginx-php-fpm

## Overview

This is a Dockerfile / image for Nginx and PHP-FPM

### Versioning
| Docker Tag | Git Release | Nginx Version | PHP Version | Alpine Version |
|-----|-------|-----|--------|--------|
| 8.0.13-alpine3.13 | main branch |1.18.0 | 8.0.13 | 3.13 |
| 8.0.13-alpine3.14 | main branch |1.20.2 | 8.0.13 | 3.14 |

## Quick Start

### Setup

1. Install hadolint, pre-commit package in local.

### Running
To simply run the container:
```
docker run --rm hashman/nginx-php-fpm:8.0.13-alpine3.13
```

## Configuration

### Environment

* `N_WORKER`: Default is 1. You can create multiple PHP-FPM workers by setting this variable.
