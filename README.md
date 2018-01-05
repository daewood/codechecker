# Run

>docker run -it --rm -p 18001:8001 -v $HOME/works:/works daewood/codechecker /bin/bash

>docker run -d --name codechecker -p 18001:8001 -v $HOME/works:/works daewood/codechecker

>docker exec -it codechecker /bin/bash

# Usage

### Analyze your project with the check command:

>CodeChecker check -b "cd /works/myproj && make clean && make" -o /work/results

*check will print an overview of the issues found in your project by the analyzers.*

### Start a CodeChecker web and storage server in another terminal or as a background process. By default it will listen on localhost:8001.

*The SQLite database containing the reports will be placed in your workspace directory (~/.codechecker by default), which can be provided via the -w flag.*

>CodeChecker server

### Store your analysis reports onto the server to be able to use the Web Viewer.

>CodeChecker store ~/results -n myproj
