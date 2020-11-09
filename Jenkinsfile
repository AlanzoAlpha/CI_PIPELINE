pipeline{
        agent any
        environment {
		DB_PASSWORD=credentials('DATABASE_URI')
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
       
            stage('Build'){
                steps{
                    sh '''
                    echo "Yes it's done"
		    "echo ${DB_PASSWORD}"
                    '''

                }
            }
          
      }
}
