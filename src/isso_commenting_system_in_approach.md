### Introduction

It takes a big month for me to use the [Isso comment system](http://posativ.org/isso/). I achieve this. But I do more. In this post I will explain you what tools I make for Isso to work for more than one user.

### Test Isso without breaking our computer

As I wanted to test Isso and do some things on it, I decide to do a Docker file for it. Docker is a system that permit to make container for some applications so that you can use the container on more than one computer and share your Docker file to any user that want to test a specific application. A kind of executable for *lambda* user.

I can give you the result, and so here is [my Docker for Isso](https://index.docker.io/u/bl4n/isso).

Here is a quick example of how it's easy to launch a commenting system server with Docker (if installed):

    docker pull bl4n/isso
    docker run -d -p 8080:8080 --name isso -v /srv/isso/:/opt/isso -v /srv/issodb/:/opt/issodb bl4n/isso
    docker start isso

And now you're OK to play with Isso on http://localhost:8080/.

But this task of making Docker file didn't be this Docker file. I do more: I make a system that permit to launch more than one Isso commenting system.

### A commenting system service

As Isso don't offer a service to make a new commenting system server for free, I think about a way to do it. I prefer that Makefly's user can choose either to install their own Isso commenting system server or to just create an account on a website.

I prefer not hosting some service, but I found another solution so that a service can appears on the Internet: create tools to make a Isso commenting system service.

So I create a tutorial and generate some scripts that permit to create a service for Isso. All [scripts are on Github](http://github.com/blankoworld/rave-comment/ "Learn more about Rave project which aims to create an Isso commenting system service").

### To have more

The first part works well: create an Isso commenting system with just some elements of a user.

But some elements are needed. For an example a website to manage users, registrations and permit user to manage their account. This is the second big part of this Isso commenting system service.

If you're interested in helping to make a web interface for an Isso commenting system service, please [send me an email](mailto:olivier+makefly@dossmann.nt "Send an email to ask about helping managing user by making a web interface for Iss commenting system service.")

### Conclusion

As I have a personnal online commenting system with Isso working, I will continue developement on Makefly v0.4 to integrate Isso commenting system. I planned to include the possibility to have another commenting system such as Disqus.

Feel free to give your comments or suggestion about Makefly, the development, the tool choices, etc.
