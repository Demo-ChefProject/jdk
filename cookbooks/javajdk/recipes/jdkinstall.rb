jdk_download_from = "#{node['nc4']['nexus']['url']}/#{node['nc4']['jdk']['version']}/#{node['nc4']['jdk']['package']}"
jdk_package_name = node['nc4']['jdk']['package']
jdk_install_loc = node['nc4']['jdk']['install_location']

#Downloads the jdk file
remote_file "#{jdk_install_loc}/#{jdk_package_name}" do
  source jdk_download_from
  action :create
end

#Installs jdk
windows_package 'Java jdk install' do
  source jdk_download_from
  installer_type :custom
  remote_file_attributes ({
    :path => 'C:\Program Files\Java\jdk-64bit-7.101.exe'
  })
end

#Set path variables for Java
powershell_script 'Set JAVA_HOME, JRE_HOME path' do
  guard_interpreter :powershell_script
  code <<-EOH
    setx JAVA_HOME "#{jdk_install_loc}\jdk1.7.0_101" /M
    setx JRE_HOME "#{jdk_install_loc}\jdk1.7.0_101\jre" /M
  EOH
end

=begin
#Trying with variables
jdk_install_loc = node['nc4']['jdk']['install_location']
jdk_package_name = node['nc4']['jdk']['package']
jdk_download_from = "#{node['atb']['nexus']['url']}/#{node['atb']['jdk']['version']}/#{node['nc4']['jdk']['package']}"

#Downloads the jdk file
remote_file "#{jdk_install_loc}/#{jdk_package_name}" do
  source jdk_download_from
  action :create
end

#Installs jdk
windows_package 'Java jdk-64bit-7.101 install' do
  source jdk_download_from
  installer_type :custom
  remote_file_attributes ({
    :path => "#{jdk_install_loc}/#{jdk_package_name}"
  })
end

#Set path
powershell_script 'Set JAVA_HOME, JRE_HOME path' do
  guard_interpreter :powershell_script
  code <<-EOH
    setx JAVA_HOME "C:\Program Files\Java\jdk1.7.0_101" /M
    setx JRE_HOME "C:\Program Files\Java\jdk1.7.0_101\jre" /M
  EOH
end
=end
