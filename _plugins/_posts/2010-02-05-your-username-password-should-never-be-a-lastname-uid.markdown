---
  title: Your username/password should never be a lastname/uid
  category: Authentication
  tags:
    - passwords
    - authentication
  layout: post
---

I'm developing an application where the client wants the username and password combination to be a lastname and member ID number.

This is stupid. If you are requiring two bits of information (OAuth and OpenID require two bits as well, twitter name/confirmation and URL/confirmation respectively), make it the user's email address and their password. Why?

Because if I am a member of your organization and know you, I know your last name. If this is a membership site touting it's number of user's etc., chances are I will eventually find out your last name. Meaning I can masquerade as you. Funstuff.

If you require that the password be the member's ID number, then at least we can do you a solid and hide the user's email on the website. Then it won't be as straightforward (careful, security by obscurity never works for anyone).

I'm all for OpenID or something else if you want though :) And if you can manage to get foaf+ssl working, awesome.

Just make sure your username/password combination is sane.