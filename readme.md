# Jenkins Docker Image
## Testing
* `docker build -t devtag .`
* `docker run -p 80:80 --name jenkins --rm devtag`
## Pushing Changes
* `docker build -t 379561783016.dkr.ecr.us-east-1.amazonaws.com/jenkins:latest .`
* `docker push 379561783016.dkr.ecr.us-east-1.amazonaws.com/jenkins:latest`
