# [WaWision](https://www.wawision.de/) @ Docker

This is a solution to generate a [WaWision](https://www.wawision.de/) docker container into your ECS private repo.

### Build container

To generate the container you should follow the following steps:

1. install `aws-cli` and define a profile with `$ aws configure -p ${YOUR-AWS-PROFILE}`
2. download the latest Wawision from the [Download Section of WaWision](https://www.wawision.de/downloads) and rename it to `17.3_oss_wawision.tar.gz`
3. copy the `deploy.env.skeleton` and `config.env.skeleton` to `deploy.env` and `config.env`
4. define the variables `${...}` inside the files `deploy.env` and `config.env`
5. to generate the container call `$ make build`
6. if (5.) succeeded you can define the version in `version.sh` and call `$ make release` to push the container to your private ECS repo

All make commands with help can be viewed by calling `$ make help`

>To handle the userdata i mapped a volume from the host machine and synced it via [AWS-EFS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using_efs.html).

### Note

Some Versions inside the Dockerfile are hard-coded. 
So the build could break.

## The MIT License (MIT)

Copyright © 2018 M. Peter, https://github.com/mpneuried

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.