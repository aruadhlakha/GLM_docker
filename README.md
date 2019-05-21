
# Usage

```
# get the container
docker pull hydrobert/glm-aed2
# to run GLM-AED
docker run -it robertladwig/glm-aed2 /bin/bash
# to run it with a modeling setup
docker run -i -t -v /Users/...:/GLM/yourmodel hydrobert/glm-aed2 /bin/bash
```
Forked from: https://github.com/jsta/GLM_docker.
Added functional AED2 setup.
This container will run a coupled GLM-AED2 simulation (current build has v.3.0beta12).
More information is available here: http://aed.see.uwa.edu.au/research/models/GLM/.
