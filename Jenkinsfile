pipeline{
        agent any
        environment {
		DATABASE_URI=credentials('DATABASE_URI')
		MYSQL_ROOT_PASSWORD=credentials('MYSQL_ROOT_PASSWORD')
		SECRET_KEY=credentials('SECRET_KEY')
		TEST_DATABASE_URI=credentials('TEST_DATABASE_URI')
                USER_DB_ENDPOINT=credentials('USER_DB_ENDPOINT')
                TEST_DB_ENDPOINT=credentials('TEST_DB_ENDPOINT')
                USERNAME=credentials('USERNAME')
		
        }
        stages{
            stage('clone my repo'){
                steps{
                    sh '''
                    rm -rf cne-sfia2-brief
		    git clone https://github.com/AlanzoAlpha/cne-sfia2-brief.git -b featured
		    echo "I am working":wq
                    '''
                    
                }
	    }
            stage('Build'){
                steps{
                    sh '''
		    sudo systemclt start nginx
		    export DATABASE_URI=${DATABASE_URI}
                    export SECRET_KEY=${SECRET_KEY}
                    export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
		    export USERNAME=${USERNAME}
		    echo ${DATABASE_URI}
		    echo ${SECRET_KEY}
		    echo ${MYSQL_ROOT_PASSWORD}
		    echo ${USERNAME}
                    cd cne-sfia2-brief/database
                    mysql -h ${USER_DB_ENDPOINT} -P 3306 -u ${USERNAME} -p${MYSQL_ROOT_PASSWORD} < Create.sql
                    sudo systemctl stop nginx
		    cd ..
		    sudo docker-compose up -d --build
		    sudo curl localhost:80
                    '''
                }
            }
            stage('Test'){
                steps{
                    sh '''
		    export TEST_DATABASE_URI=${TEST_DATABASE_URI}
                    export TEST_DB_ENDPOINT=${USER_DB_ENDPOINT}
		    export SECRET_KEY=${SECRET_KEY}
                    export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
                    echo ${USER_DB_ENDPOINT}
		    echo ${TEST_DATABASE_URI}
		    cd cne-sfia2-brief/database
		    mysql -h ${TEST_DB_ENDPOINT} -P 3306 -u ${USERNAME} -p${MYSQL_ROOT_PASSWORD} < Create.sql
		    cd ..
		    echo "BACKEND TEST"
		    sudo docker exec backend bash -c "pytest tests/ --cov application"
		    sudo docker exec backend bash -c "pytest tests/ --cov application" >> backend_test_coverage.txt
		    echo "FRONTEND TEST TEST"
		    sudo docker exec frontend bash -c "pytest tests/ --cov application"
		    sudo docker exec frontend bash -c "pytest tests/ --cov application" >> frontend_test_coverage.txt

                    '''

                }
            }
            
      }
}
