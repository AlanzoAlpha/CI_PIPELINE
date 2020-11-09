pipeline{
        agent any
        //environment {
        //}
        stages{
            stage('clone my repo'){
                steps{
                    sh '''
                    //Remove repository if exist
                    rm -rf cne-sfia2-brief
                    //Clone repository 
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
