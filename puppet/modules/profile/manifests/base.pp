class profile::base (
	
		#$stringtest = 	hiera('stringtest', "Default puppet value"),
		#$listtest = 	hiera('listtest', [ "Value1 : Default", "Value2 : Default" ])
	
	){

    	#notify { "Value of stringtest: ${stringtest}":
    	#	withpath => true
    	#}

		#file { "/tmp/stringtest":
        #	content => $stringtest,
        #	ensure => present
    	#}

    	#$sorted = sort($listtest)

    	#file { "/tmp/firstitem":
    	#	content => $sorted[0],
    	#	ensure => present
    	#}   	
}
