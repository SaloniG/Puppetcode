class mysqltask {


        exec { 'repo_install':
                command => "rpm -ivh https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm",
                cwd     => '/var/tmp',
                path    => ['/usr/bin', '/usr/sbin',],
        }
        $pack = [ 'mysql-server', 'MySQL-python']
        package {$pack:
                ensure  => installed,
                require => Exec["repo-install"],
        }
        service {'mysqld':
                ensure => running,
        }
        class { '::mysql::server':
                root_password    => 'strongpassword',
                override_options => { 'mysqld' => { 'max_connections' => '1024' } }
        }

}

