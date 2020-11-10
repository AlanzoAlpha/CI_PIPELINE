pipeline{
        agent any
        environment {
		DATABASE_URI=credentials('DATABASE_URI')
		MYSQL_ROOT_PASSWORD=credentials('MYSQL_ROOT_PASSWORD')
		SECRET_KEY=credentials('SECRET_KEY')
		TEST_DATABASE_URI=credentials('TEST_DATABASE_URI')
		
        }
        stages{
            stage('clone my repo'){
                steps{
                    sh '''
                    rm -rf cne-sfia2-brief
		    git clone https://github.com/AlanzoAlpha/cne-sfia2-brief.git
                    '''
                    
                }
            }
            
            stage('Test'){
                steps{
                    sh '''
		    cd cne-sfia2-brief
		    export TEST_DATABASE_URI=${TEST_DATABASE_URI}
		    echo ${TEST_DATABASE_URI}
		    pytest test_backend.py
		    pytest test_frontend.py
		    
                    '''

                }
            }
            stage('Build'){
                steps{
                    sh '''
		    cd cne-sfia2-brief
		    export DATABASE_URI=${DATABASE_URI}
                    export SECRET_KEY=${SECRET_KEY}
                    export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
                    echo "Yes it's done"
		    echo ${DATABASE_URI}
		    echo ${SECRET_KEY}
		    echo ${MYSQL_ROOT_PASSWORD}
		    sudo docker-compose up -d --build
                    '''

                }
            }
          
      }
}
