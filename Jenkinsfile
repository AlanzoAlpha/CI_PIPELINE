pipeline{
        agent any
        environment {
		DATABASE_URI=credentials('DATABASE_URI')
		MYSQL_ROOT_PASSWORD=credentials('MYSQL_ROOT_PASSWORD')
		ECRET_KEY=credentials('SECRET_KEY')
		EST_DATABASE_URI=credentials('TEST_DATABASE_URI')
                USER_DB_ENDPOINT=credentials('USER_DB_ENDPOINT')
                EST_DB_ENDPOINT=credentials('TEST_DB_ENDPOINT')
                DOCKER_USERNAME=credentials('DOCKER_USERNAME')
		DOCKER_PASSWORD=credentials('DOCKER_PASSWORD')
		DOCKER_USERNAME=credentials('DOCKER_USERNAME')
		
        }
        stages{
            stage('Jenkin Test'){
                steps{
                    sh '''
		    rm -rf cne-sfia2-brief
		    git clone https://github.com/AlanzoAlpha/cne-sfia2-brief.git -b featured
		    echo "Hello World"
                    '''
                    
                }
	    }
	   
            stage('Docker Build'){
                steps{
                    sh '''
		    sudo systemctl disable nginx
		    export DATABASE_URI=${DATABASE_URI}
		    export TEST_DATABASE_URI=${TEST_DATABASE_URI}
                    export SECRET_KEY=${SECRET_KEY}
                    export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
                    cd cne-sfia2-brief/database
                    mysql -h ${USER_DB_ENDPOINT} -P 3306 -u ${USERNAME} -p${MYSQL_ROOT_PASSWORD} < Create.sql
                    mysql -h ${TEST_DB_ENDPOINT} -P 3306 -u ${USERNAME} -p${MYSQL_ROOT_PASSWORD} < Create.sql
                    cd ..
		    sudo docker-compose up -d --build 
		    sudo curl localhost:80
                    '''
                }
            }
	   stage('Docker Push '){
                steps{
                    sh '''
		    sudo docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
		    sudo docker push ${DOCKER_USERNAME}/frontend
		    sudo docker push ${DOCKER_USERNAME}/backend
		    sudo docker push ${DOCKER_USERNAME}/mysql-image
		    sudo docker push ${DOCKER_USERNAME}/nginx
                    '''

                }
            }
            stage('Test'){
                steps{
                    sh '''
		    cd ~/cne-sfia2-brief
		    echo "BACKEND TEST"
		    sudo docker exec backend bash -c "pytest tests/ --cov application"
		    sudo docker exec backend bash -c "pytest tests/ --cov application" >> backend_test_coverage.txt
		    echo "FRONTEND TEST"
		    sudo docker exec frontend bash -c "pytest tests/ --cov application"
		    sudo docker exec frontend bash -c "pytest tests/ --cov application" >> frontend_test_coverage.txt
                    echo "Done"
                    '''

                }
            }
            stage('Kubes'){
                steps{
                    sh '''
		    cd ~/cne-sfia2-brief/
		    sudo kubectl apply -f secrets.yaml
		    sudo kubectl apply -f deployment.yaml 
		    sudo kubectl apply -f configmap.yaml
		    sudo kubectl apply -f frontend.yaml
		    sudo kubectl apply -f backend.yaml
		    sudo kubectl apply -f mysql.yaml
		    sudp kubectl apply -f nginxservice.yaml
                    echo "Done"
                    '''

                }
	   }    
      }
}
