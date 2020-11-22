pipeline{
        agent any
        /*environment {
		//DATABASE_URI=credentials('DATABASE_URI')
		//MYSQL_ROOT_PASSWORD=credentials('MYSQL_ROOT_PASSWORD')
		//SECRET_KEY=credentials('SECRET_KEY')
		//TEST_DATABASE_URI=credentials('TEST_DATABASE_URI')
                //USER_DB_ENDPOINT=credentials('USER_DB_ENDPOINT')
                //TEST_DB_ENDPOINT=credentials('TEST_DB_ENDPOINT')
                //DOCKER_USERNAME=credentials('DOCKER_USERNAME')
		DOCKER_PASSWORD=credentials('DOCKER_PASSWORD')
		
        } */
        stages{
            stage(' Jenkin Test'){
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
		    sudo systemctl stop nginx
		    echo "//export DATABASE_URI=${DATABASE_URI}"
		    export DATABASE_URI=mysql+pymysql://admin:password@terraform-20201122035734758000000008.cqelbtnl3tpk.eu-west-1.rds.amazonaws.com:3306/users
                    echo "//export SECRET_KEY=${SECRET_KEY}"
		    export SECRET_KEY=qdfghwsd
                    echo "//export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}"
		    export MYSQL_ROOT_PASSWORD=password
                    cd cne-sfia2-brief/database
                    echo "//mysql -h ${USER_DB_ENDPOINT} -P 3306 -u ${USERNAME} -p${MYSQL_ROOT_PASSWORD} < Create.sql"
		    mysql -h terraform-20201122035734758000000008.cqelbtnl3tpk.eu-west-1.rds.amazonaws.com -P 3306 -u admin -ppassword < Create.sql
                    cd ..
		    sudo docker-compose up -d --build
		    sudo curl localhost:80
                    '''
                }
            }
	   /* stage('Docker Push '){
                steps{
                    sh '''
		    sudo docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
		    sudo docker push ${DOCKER_USERNAME}/
		    sudo docker push ${DOCKER_USERNAME}/
		    sudo docker push ${DOCKER_USERNAME}/
		    sudo docker push ${DOCKER_USERNAME}/
                    '''

                }
            }*/
            stage('Test'){
                steps{
                    sh '''
		    echo "//export TEST_DATABASE_URI=${TEST_DATABASE_URI}"
		    export TEST_DATABASE_URI=mysql+pymysql://admin:password@terraform-20201122035734755200000007.cqelbtnl3tpk.eu-west-1.rds.amazonaws.com:3306/testdb
                    echo "//export TEST_DB_ENDPOINT=${USER_DB_ENDPOINT}"
		    echo "//export SECRET_KEY=${SECRET_KEY}"
		    export SECRET_KEY=qdfghwsd
                    echo "//export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}"
		    export MYSQL_ROOT_PASSWORD=password
		    cd cne-sfia2-brief/database
		    mysql -h terraform-20201122035734755200000007.cqelbtnl3tpk.eu-west-1.rds.amazonaws.com -P 3306 -u admin -ppassword < Create.sql
		    cd ..
		    echo "BACKEND TEST"
		    sudo docker exec backend bash -c "pytest tests/ --cov application"
		    echo "//sudo docker exec backend bash -c "pytest tests/ --cov application" >> backend_test_coverage.txt"
		    echo "FRONTEND TEST"
		    sudo docker exec frontend bash -c "pytest tests/ --cov application"
		    echo "//sudo docker exec frontend bash -c "pytest tests/ --cov application" >> frontend_test_coverage.txt"
                    echo "Done"
                    '''

                }
            }
            /*stage('Test'){
                steps{
                    sh '''
		    cd ~/cne-sfia2-brief/
		    kubectl apply -f secrets.yaml
		    kubectl apply -f deploy 
		    kubectl apply -f configmap.yaml
		    kubectl apply -f frontend.yaml
		    kubectl apply -f backend.yaml
		    kubectl apply -f mysql.yaml
                    echo "Done"
                    '''

                }
            }
           */     
      }
}
