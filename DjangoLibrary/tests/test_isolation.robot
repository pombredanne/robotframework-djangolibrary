*** Variables ***

${SERVER}               http://localhost:55001
${BROWSER}              firefox


*** Settings ***

Documentation   Testing Test Isolation
Library         Selenium2Library  timeout=10  implicit_wait=0.5
Library         DjangoLibrary  127.0.0.1  55001
Library         DebugLibrary
Suite Setup     Start Django and Open Browser
Suite Teardown  Stop Django and Close Browser


*** Keywords ***

Start Django and open Browser
  Start Django
  Open Browser  ${SERVER}  ${BROWSER}

Stop Django and close browser
  Close Browser
  Stop Django


*** Test Cases ***

Test One: Create User
  Create User  test-user-1  test@test.com  password  is_superuser=True  is_staff=True

Test Two: No user should be present
  Autologin as  admin  password
  Go To  ${SERVER}/admin/auth/user/
  Wait until page contains  Select user to change
  Page should not contain  test-user-1
