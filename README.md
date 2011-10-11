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

      def send_email(action)
        puts "Thanks for #{action} my website"
      end

      get_back :send_email

    end

Now the send_email method will *always* run in a separate thread.

The background methods are run in a separate thread.  The threads a pulled from a pool.  If you need to limit the
concurrency of a method, you can fix the pool size:

    get_back :send_email, :pool => 10

You can also specify callbacks for success, rescue, and ensure.  The success callback is just a block thats passed to
the get_back call:

    get_back :send_email do
      log.info "email send successfully
    end

The rescue and ensure callbacks reference other methods

    get_back :send_email, :rescue => :log_bad_email

    def log_bad_email(e) do
      log.error "something bad happened when we sent an email!"
    end

Or you can send more email:

    get_back :send_mail, :ensure => :send_spam

    def send_spam
      send_email("spamming")
    end

Copyright
----------

Copyright © 2011 Joe Kutner. Released under the MIT License.

See LICENSE for details.
