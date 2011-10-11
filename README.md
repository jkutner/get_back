get_back
==========

Get_Back is a library for making a Ruby method run in the background.  But it only works with JRuby.

Examples
---------

Lets say you want to send an email as part of your sign up process.  But you don't want that to run synchronously cause
it could take too long.  Make it get back!

    require 'get_back'

    class User
      extend GetBack::JoJo

      def send_email
        puts "Thanks for joining my website"
      end

      get_back :send_email

    end

Now the send_email method will *always* run in a separate thread.

The background methods are run in a separate thread.  The threads a pulled from a pool.  If you need to limit the
concurrency of a method, you can fix the pool size:

    get_back :send_email, :pool => 10

