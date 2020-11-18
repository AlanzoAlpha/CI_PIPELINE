pipeline{
        agent any
        environment {
		DATABASE_URI=credentials('DATABASE_URI')
		MYSQL_ROOT_PASSWORD=credentials('MYSQL_ROOT_PASSWORD')
		SECRET_KEY=credentials('SECRET_KEY')
		TEST_DATABASE_URI=credentials('TEST_DATABASE_URI')
                USER_DB_ENDPOINT=credentials('USER_DB_ENDPOINT')
                USER_DB_ENDPOINT=credentials('USER_DB_ENDPOINT')
                USERNAME=credentials('USERNAME')
                PASSWORD=credentials('PASSWORD')
		
        }
        stages{
            stage('clone my repo'){
                steps{
                    sh '''
                    rm -rf cne-sfia2-brief
		    git clone https://github.com/AlanzoAlpha/cne-sfia2-brief.git -b featured
                    '''
                    
                }
            }
            
            stage('Test'){
                steps{
                    sh '''
		    export TEST_DATABASE_URI=${TEST_DATABASE_URI}
		    echo ${TEST_DATABASE_URI}
                    export USER_DB_ENDPOINT=${USER_DB_ENDPOINT}
                    echo ${USER_DB_ENDPOINT}
                    export USERNAME=${USERNAME}
                    echo ${USERNAME}
                    export PASSWORD=${PASSWORD}
                    echo ${PASSWORD}
		    cd ~/cne-sfia2-brief/backend
		    pip3 install -r requirements.txt
                    cd ~/cne-sfia2-brief/database
                    mysql -h ${TEST_DB_ENDPOINT}.cqelbtnl3tpk.eu-west-1.rds.amazonaws.com -P 3306 -u ${USERNAME} -p${PASSWORD} < Create.sql
                    cd ~/cne-sfia2-brief
		    pytest 
		    pytest --cov application

                    '''

                }
            }
            stage('Build and Push'){
                steps{
                    sh '''
		    export DATABASE_URI=${DATABASE_URI}
                    export SECRET_KEY=${SECRET_KEY}
                    export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
                    echo "Yes it's done"
		    echo ${DATABASE_URI}
		    echo ${SECRET_KEY}
		    echo ${MYSQL_ROOT_PASSWORD}
                    cd ~/cne-sfia2-brief/database
                    mysql -h ${USER_DB_ENDPOINT}.cqelbtnl3tpk.eu-west-1.rds.amazonaws.com -P 3306 -u ${USERNAME} -p${PASSWORD} < Create.sql
                    cd ~/cne-sfia2-brief
		    sudo docker-compose up -d --build
                    '''

                }
            }
           
            
      }
}
