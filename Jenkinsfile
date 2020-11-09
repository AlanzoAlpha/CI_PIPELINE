pipeline{
        agent any
        environment {
		DB_PASSWORD=credentials('DATABASE_PASSWORD')
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
		    sh "echo ${DB_PASSWORD}"
                    '''

                }
            }
          
      }
}
