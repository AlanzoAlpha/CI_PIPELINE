pipeline{
        //agent any
        //environment {
        }
        stages{
            stage('clone my repo'){
                steps{
                    sh '''
                    ssh ubuntu@52.17.67.226 <<EOF
                    //install git 
		    sudo apt update
		    sudo apt install -y git
                    //Remove repository if exist
                    rm -rf cne-sfia2-brief
                    //Clone repository 
		    git clone https://github.com/AlanzoAlpha/cne-sfia2-brief.git
		    EOF
                    '''
                    
            }
        }
       
            stage('Software Installation'){
                steps{
                    sh '''
                    ssh ubuntu@52.17.67.226 <<EOF
                    sudo apt update
                    //Docker installations
                    curl https://get.docker.com | sudo bash
                    //Add docker user to the group 
                    sudo usermod -aG docker $(whoami)
                    // install nginx 
                    sudo apt update
		    sudo apt install -y nginx
                    //
		    //make sure jq & curl is installed
                    sudo apt update
                    sudo apt install -y curl jq
                    //set which version to download (latest)
                    version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r '.tag_name')
                    //download to /usr/local/bin/docker-compose
                    sudo curl -L "https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                    // make the file executable
                    sudo chmod +x /usr/local/bin/docker-compose		
                    EOF
                    '''

              }
            }
          
          }
       }
