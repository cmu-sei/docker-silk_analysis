[![Software Engineering Institute](https://avatars.githubusercontent.com/u/12465755?s=200&v=4)](https://www.sei.cmu.edu/)

[![Blog](https://img.shields.io/static/v1.svg?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=SEI&message=Blog)](https://insights.sei.cmu.edu/blog/ "blog posts from our experts in Software Engineering.")
[![Youtube](https://img.shields.io/static/v1.svg?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=SEI&message=Youtube&logo=youtube)](https://www.youtube.com/@TheSEICMU/ "vidoes from our experts in Software Engineering.")
[![Podcasts](https://img.shields.io/static/v1.svg?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=SEI&message=Podcasts&logo=applepodcasts)](https://insights.sei.cmu.edu/podcasts/ "podcasts from our experts in Software Engineering.")
[![GitHub](https://img.shields.io/static/v1.svg?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=SEI&message=GitHub&logo=github)](https://github.com/cmu-sei "view the source for all of our repositories.")
[![Flow Tools](https://img.shields.io/static/v1.svg?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=SEI&message=Flow%20Tools)](https://tools.netsa.cert.org/ "documentation and source for all our flow collection and analysis tools.")


At the [SEI](https://www.sei.cmu.edu/), we research software engineering, cybersecurity, and AI engineering problems; create innovative technologies; and put solutions into practice.

Find us at:

* [Blog](https://insights.sei.cmu.edu/blog/) - blog posts from our experts in Software Engineering.
* [Youtube](https://www.youtube.com/@TheSEICMU/) - vidoes from our experts in Software Engineering.
* [Podcasts](https://insights.sei.cmu.edu/podcasts/) - podcasts from our experts in Software Engineering.
* [GitHub](https://github.com/cmu-sei) - view the source for all of our repositories.
* [Flow Tools](https://tools.netsa.cert.org/) - documentation and source for all our flow collection and analysis tools.

# [certcc/silk](https://tools.netsa.cert.org/silk/docs.html)

[![CI](https://img.shields.io/github/actions/workflow/status/cmu-sei/docker-silk_analysis/release.yml?style=for-the-badge&logo=github)](https://github.com/cmu-sei/docker-silk_analysis/actions?query=workflow%3ARelease) [![Docker pulls](https://img.shields.io/docker/pulls/cmusei/silk_analysis?color=468f8b&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pulls&logo=docker)](https://hub.docker.com/r/cmusei/silk_analysis/)

SiLK, the System for Internet-Level Knowledge, is a collection of traffic analysis tools developed by the [CERT Network Situational Awareness Team](www.cert.org/netsa) (CERT NetSA) to facilitate security analysis of large networks. The SiLK tool suite supports the efficient collection, storage, and analysis of network flow data, enabling network security analysts to rapidly query large historical traffic data sets. SiLK is ideally suited for analyzing traffic on the backbone or border of a large, distributed enterprise or mid-sized ISP.

A SiLK installation consists of two categories of applications: the packing system and the analysis suite. The packing system collects IPFIX, NetFlow v9, or NetFlow v5 and converts the data into a more space efficient format, recording the packed records into service-specific binary flat files. The analysis suite consists of tools which read these flat files and perform various query operations, ranging from per-record filtering to statistical analysis of groups of records. The analysis tools interoperate using pipes, allowing a user to develop a relatively sophisticated query from a simple beginning.  This image contains **only** the analysis suite tools.

The vast majority of the current code-base is implemented in C, Perl, or Python. This code has been tested on Linux, Solaris, OpenBSD, Mac OS X, and Cygwin, but should be usable with little or no change on other Unix platforms.

The SiLK software components are released under [the GNU General Public License V2](https://tools.netsa.cert.org/silk/license.html). 

## Documentation

More information [here](https://tools.netsa.cert.org/silk/docs.html).

## Usage

The intention of this container image is to allow for usage of the SiLK analysis collection of command-line tools for processing SiLK Flow records created by the [SiLK packing system](https://tools.netsa.cert.org/silk/docs.html#packing). Here are some example snippets to help get you started.

### FCCX-15 Reference Data

Example reference data for SiLK can be found [here](http://tools.netsa.cert.org/silk/referencedata.html).  Download and unpack the data set with:

```bash
curl https://tools.netsa.cert.org/silk/refdata/FCCX-silk.tar.gz | tar -xz -
```

To print information about the network sensors and the earliest and latest date for files in the data set, run:
```bash
docker run --rm -it -v $PWD/FCCX-silk:/data:ro \
  cmusei/silk_analysis:latest \
  rwsiteinfo \
  --fields=sensor,describe-sensor,repo-start-date,repo-end-date
```
```
Sensor|Sensor-Description|         Start-Date|           End-Date|
    S0|           Div0Ext|2015/06/16T12:00:00|2015/06/18T18:00:00|
    S1|           Div1Ext|2015/06/16T12:00:00|2015/06/18T18:00:00|
    S2|           Div0Int|2015/06/16T12:00:00|2015/06/18T18:00:00|
    S3|          Div1Int1|2015/06/16T12:00:00|2015/06/17T18:00:00|
    S4|          Div1Int2|2015/06/16T12:00:00|2015/06/17T18:00:00|
    S5|          Div1log1|2015/06/02T13:00:00|2015/06/17T19:00:00|
    S6|          Div1log2|2015/06/02T13:00:00|2015/06/17T19:00:00|
    S7|          Div1log3|2015/06/02T13:00:00|2015/06/17T19:00:00|
    S8|          Div1log4|2015/06/02T13:00:00|2015/06/17T18:00:00|
    S9|          Div1ops1|2015/06/02T13:00:00|2015/06/18T17:00:00|
   S10|          Div1ops2|2015/06/02T13:00:00|2015/06/18T17:00:00|
   S11|          Div1ops3|2015/06/02T13:00:00|2015/06/18T17:00:00|
   S12|           Div1svc|2015/06/02T13:00:00|2015/06/18T17:00:00|
   S13|           Div1dhq|2015/06/02T13:00:00|2015/06/17T18:00:00|
   S14|           Div1dmz|2015/06/02T13:00:00|2015/06/18T14:00:00|
   S15|           Div1mar|2015/06/02T13:00:00|2015/06/18T16:00:00|
   S16|           Div1med|2015/06/02T13:00:00|2015/06/17T18:00:00|
   S17|          Div1nusr|2015/06/02T13:00:00|2015/06/18T17:00:00|
   S18|           Div1mgt|2015/06/17T14:00:00|2015/06/18T17:00:00|
   S19|        Div1intel1|2015/06/02T13:00:00|2015/06/17T19:00:00|
   S20|        Div1intel2|2015/06/02T13:00:00|2015/06/17T19:00:00|
   S21|        Div1intel3|2015/06/02T13:00:00|2015/06/17T18:00:00|   
```

Pull records of interest from the data set and store them in ``flows.rw`` on the docker host:
```bash
docker run --rm -it -v $PWD/FCCX-silk:/data:ro -v $PWD/output:/tmp \
  cmusei/silk_analysis:latest \
  rwfilter \
  --start=2015/06/17T14 \
  --end=2015/06/17T14 \
  --sensor=S1 \
  --type=all \
  --any-address=192.168.70.10 \
  --pass=/tmp/flows.rw
```

View the flow records from the previous ``rwfilter`` command with ``rwcut``:
```bash
docker run --rm -it -v $PWD/FCCX-silk:/data:ro -v $PWD/output:/tmp \
  cmusei/silk_analysis:latest \
  rwcut \
  --fields=sip,dip,sport,dport,protocol,stime \
  --num-recs=10 \
  /tmp/flows.rw
```
```
                                    sIP|                                    dIP|sPort|dPort|pro|                  sTime|
                             10.0.40.83|                          192.168.70.10|53981| 8082|  6|2015/06/17T14:00:02.631|
                             10.0.40.20|                          192.168.70.10|   53|58887| 17|2015/06/17T14:00:04.619|
                             10.0.40.20|                          192.168.70.10|   53|55004| 17|2015/06/17T14:00:04.621|
                             10.0.40.83|                          192.168.70.10|53982| 8082|  6|2015/06/17T14:00:12.673|
                             10.0.40.20|                          192.168.70.10|   53|64408| 17|2015/06/17T14:00:14.685|
                             10.0.40.20|                          192.168.70.10|   53|57734| 17|2015/06/17T14:00:14.689|
                             10.0.40.83|                          192.168.70.10|53983| 8082|  6|2015/06/17T14:00:22.709|
                             10.0.40.20|                          192.168.70.10|   53|63770| 17|2015/06/17T14:00:24.753|
                             10.0.40.20|                          192.168.70.10|   53|53374| 17|2015/06/17T14:00:24.755|
                             10.0.40.83|                          192.168.70.10|53984| 8082|  6|2015/06/17T14:00:32.741|
```

If you would like to make use of [linux pipes](https://en.wikipedia.org/wiki/Pipeline_(Unix)), you can overwrite the container entrypoint and set the `-c` option to bash.  For example:

```bash
docker run --rm -it -v $PWD/FCCX-silk:/data:ro \
  --entrypoint=/bin/bash \
  cmusei/silk_analysis:latest \
  -c 'rwfilter \
  --start=2015/06/17T14 \
  --end=2015/06/17T14 \
  --sensor=S1 \
  --type=all \
  --any-address=192.168.70.10 \
  --pass=stdout | \
  rwcut \
  --fields=sip,dip,sport,dport,protocol,stime \
  --num-recs=10'
```
```
                                    sIP|                                    dIP|sPort|dPort|pro|                  sTime|
                             10.0.40.83|                          192.168.70.10|53981| 8082|  6|2015/06/17T14:00:02.631|
                             10.0.40.20|                          192.168.70.10|   53|58887| 17|2015/06/17T14:00:04.619|
                             10.0.40.20|                          192.168.70.10|   53|55004| 17|2015/06/17T14:00:04.621|
                             10.0.40.83|                          192.168.70.10|53982| 8082|  6|2015/06/17T14:00:12.673|
                             10.0.40.20|                          192.168.70.10|   53|64408| 17|2015/06/17T14:00:14.685|
                             10.0.40.20|                          192.168.70.10|   53|57734| 17|2015/06/17T14:00:14.689|
                             10.0.40.83|                          192.168.70.10|53983| 8082|  6|2015/06/17T14:00:22.709|
                             10.0.40.20|                          192.168.70.10|   53|63770| 17|2015/06/17T14:00:24.753|
                             10.0.40.20|                          192.168.70.10|   53|53374| 17|2015/06/17T14:00:24.755|
                             10.0.40.83|                          192.168.70.10|53984| 8082|  6|2015/06/17T14:00:32.741|
```

More examples of using the SiLK analysis tools can be found in the [SiLK Analysis Handbook](https://tools.netsa.cert.org/silk/analysis-handbook.pdf).
