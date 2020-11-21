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
		    sudo systemctl stop nginx
		    //export DATABASE_URI=${DATABASE_URI}
		    export DATABASE_URI=mysql+pymysql://admin:password@terraform-20201121201447420600000007.cqelbtnl3tpk.eu-west-1.rds.amazonaws.com:3306/users
                    //export SECRET_KEY=${SECRET_KEY}
		    export SECRET_KEY=password
                    //export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
		    export MYSQL_ROOT_PASSWORD=pasword
		    //export USERNAME=${USERNAME}
		    //export USERNAME=admin
		    echo ${DATABASE_URI}
		    echo ${SECRET_KEY}
		    echo ${MYSQL_ROOT_PASSWORD}
		    echo ${USERNAME}
                    cd cne-sfia2-brief/database
                    //mysql -h ${USER_DB_ENDPOINT} -P 3306 -u ${USERNAME} -p${MYSQL_ROOT_PASSWORD} < Create.sql
		    mysql -h terraform-20201121201447420600000007.cqelbtnl3tpk.eu-west-1.rds.amazonaws.com -P 3306 -u admin -ppassword < Create.sql
                    cd ..
		    sudo docker-compose up -d --build
		    sudo curl localhost:80
                    '''
                }
            }
            stage('Test'){
                steps{
                    sh '''
		    //export TEST_DATABASE_URI=${TEST_DATABASE_URI}
		    export TEST_DATABASE_URI=mysql+pymysql://admin:password@terraform-20201121201447428300000008.cqelbtnl3tpk.eu-west-1.rds.amazonaws.com:3306/testdb
                    //export TEST_DB_ENDPOINT=${USER_DB_ENDPOINT}
		    //export SECRET_KEY=${SECRET_KEY}
		    export SECRET_KEY=password
                    //export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
		    export MYSQL_ROOT_PASSWORD=password
                    echo ${USER_DB_ENDPOINT}
		    echo ${TEST_DATABASE_URI}
		    cd cne-sfia2-brief/database
		    mysql -h terraform-20201121201447428300000008.cqelbtnl3tpk.eu-west-1.rds.amazonaws.com -P 3306 -u admin -ppassword < Create.sql
		    cd ..
		    echo "BACKEND TEST"
		    sudo docker exec backend bash -c "pytest tests/ --cov application"
		    //sudo docker exec backend bash -c "pytest tests/ --cov application" >> backend_test_coverage.txt
		    echo "FRONTEND TEST TEST"
		    sudo docker exec frontend bash -c "pytest tests/ --cov application"
		    //sudo docker exec frontend bash -c "pytest tests/ --cov application" >> frontend_test_coverage.txt
                    echo "Done"
                    '''

                }
            }
            
      }
}
