import "./dirs.just"
import "./examples.just"
import? "./projects.just"

typst_flags := "--root ."

all: all-examples
    if [ ! -e "./projects.just" ]; then \
        echo "all-projects: " > ./projects.just; \
    fi
        
    just all-projects

clean:
    rm -rf dist
