pipeline{
        agent any
        //environment {
        //}
        stages{
            stage('clone my repo'){
                steps{
                    sh '''
                    rm -rf cne-sfia2-brief
		    git clone https://github.com/AlanzoAlpha/cne-sfia2-brief.git
                    '''
                    
                }
            }
       
            stage('Software Installation'){
                steps{
                    sh '''
                    echo "Yes it's done"
                    '''

                }
            }
          
      }
}
