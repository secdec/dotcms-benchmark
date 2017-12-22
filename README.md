# dotCMS Benchmark Overview
Testing application security  tools is often challenging, since synthetic applications are often not realistic (e.g. [WebGoat](https://www.owasp.org/index.php/Category:OWASP_WebGoat_Project)), and real world applications are often proprietary and not available to researchers. Security researchers must also spend enormous lengths of time to get an application in a runnable state to even begin testing. 

One real-world application that can be used for security testing is [dotCMS](http://dotcms.com), an open source content management system written in Java. dotCMS takes security seriously, and does a good job documenting [their process](https://dotcms.com/docs/latest/security-and-privacy), maintaining a [list of known security vulnerabilities](https://dotcms.com/security/known-issues.dot) in prior releases, and documenting security changes in their [changelog](https://dotcms.com/docs/latest/changelogs). 

Source code for dotCMS is available on [GitHub](https://github.com/dotCMS/core) in case you also want to test static analysis tools.

This Vagrant configuration sets up a running dotCMS instance, including MySQL database and various users with different access levels. By default, dotCMS 3.3.1 will be installed. The subsequent version 3.5 fixes various security vulnerabilities like SQLi ([SI-36](https://dotcms.com/security/SI-36)), XSS ([SI-33](https://dotcms.com/security/SI-33)), and Directory Traversal ([SI-34](https://dotcms.com/security/SI-34)).

To change to a different version, simply modify the `version` variable in `bootstrap.sh`.

## Getting Started

1. Start by downloading and installing Vagrant: https://www.vagrantup.com/downloads.html
2. If you don't have VirtualBox installed, you'll also need to download and install it: https://www.virtualbox.org/wiki/Downloads
3. Clone this repo
4. Open a command prompt and navigate to the directory of the VM you want to start
5. Type "Vagrant" to launch it, and wait for the VM to be set up and started
6. dotCMS should be accessible at http://localhost:8080/ (from your host)

Once the VM is running, you can type `vagrant ssh` from the directory containing the `Vagrantfile` to get shell access into the VM if needed.