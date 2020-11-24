FROM rocker/verse:3.6.3-ubuntu18.04

MAINTAINER "ARYAN ADHLAKHA" aryan@cs.wisc.edu "Robert Ladwig" #original creator: Joseph Stachelek, stachel2@msu.edu

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
	gfortran-8 \
	gfortran \ 
	libgd-dev \
	git \
	build-essential \
	libnetcdf-dev \
	ca-certificates \
	&& update-ca-certificates

RUN 	Rscript -e 'install.packages("ncdf4")' \
	&& Rscript -e 'install.packages("devtools")' \
	&& Rscript -e 'devtools::install_github("GLEON/GLM3r",ref="GLMv.3.1.0a3")' \
	&& Rscript -e 'devtools::install_github("USGS-R/glmtools", ref = "ggplot_overhaul")' 
RUN 	echo "rstudio  ALL=(ALL) NOPASSWD:ALL">>/etc/sudoers	
COPY 	configurations /home/rstudio/configurations
WORKDIR /home/rstudio/configurations
RUN 	chmod -R 777 .
	
RUN	mkdir /home/rstudio/glm

WORKDIR /home/rstudio/glm
RUN 	chmod -R 777 .

RUN git clone https://github.com/AquaticEcoDynamics/GLM.git && \
	git clone https://github.com/AquaticEcoDynamics/libplot.git && \
	git clone https://github.com/AquaticEcoDynamics/libutil.git && \
	git clone https://github.com/AquaticEcoDynamics/libaed-water.git

WORKDIR libutil

RUN F90=gfortran-8 make

WORKDIR ../libplot

RUN make

WORKDIR ../libaed-water

RUN F90=gfortran-8 make

WORKDIR ../GLM

RUN FC=gfortran-8 ./build_glm.sh

WORKDIR ..
WORKDIR ..

RUN	mkdir /home/rstudio/glm-a

WORKDIR /home/rstudio/glm-a
RUN 	chmod -R 777 .

RUN git clone https://github.com/AquaticEcoDynamics/GLM && \
	git clone https://github.com/AquaticEcoDynamics/libplot.git && \
	git clone https://github.com/AquaticEcoDynamics/libutil.git && \
	git clone https://github.com/aruadhlakha/libaed-water.git

WORKDIR libutil

RUN F90=gfortran-8 make

WORKDIR ../libplot

RUN make

WORKDIR ../libaed-water

RUN F90=gfortran-8 make

WORKDIR ../GLM

RUN FC=gfortran-8 ./build_glm.sh





