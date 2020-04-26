FROM clearlinux
RUN swupd bundle-add c-basic git vim graphviz
RUN useradd -ms /bin/bash student
USER student
WORKDIR /home/student
RUN git clone https://github.com/VictorRodriguez/compilers-lecture.git
