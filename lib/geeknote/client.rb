module GeekNote
  class Client

    @@evernoteHost = "sandbox.evernote.com" #www.evernote.com for production
    @@auth_token = "S=s1:U=840c1:E=148e577e596:C=1418dc6b999:P=1cd:A=en-devtoken:V=2:H=f597a57e759dfaba5e319931fcad97a2"


    def get_token 
      file = File.new(Dir.home+"/.geeknote", "r")
      token = file.gets
      file.close
      return token
    end


    def list_notebooks      
      client = EvernoteOAuth::Client.new(token: get_token, consumer_key:"mlc880926-8889", consumer_secret:"a298b6c359007305", sandbox: true)
      note_store = client.note_store
      notebooks = note_store.listNotebooks
      puts "your note books list ......"
      notebooks.each do |nb|
        puts nb.name
      end
    end

    def create_note(title, content)
      client = EvernoteOAuth::Client.new(token: get_token, consumer_key:"mlc880926-8889", consumer_secret:"a298b6c359007305", sandbox: true)
      note_store = client.note_store
      note = Evernote::EDAM::Type::Note.new
      note.title = title
      note.content = '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd"><en-note>Hello Evernote<br/></en-note>'
      note_store.createNote(note)
    end

    def list_tags
      client = EvernoteOAuth::Client.new(token: get_token, consumer_key:"mlc880926-8889", consumer_secret:"a298b6c359007305", sandbox: true)
      note_store = client.note_store
      tags = note_store.listTags
      puts "your tags list ......"
      tags.each do |tag|
        puts tag.name
      end
    end

    def who_am_i
      auth_token = "S=s1:U=840c1:E=148e577e596:C=1418dc6b999:P=1cd:A=en-devtoken:V=2:H=f597a57e759dfaba5e319931fcad97a2"
      client = EvernoteOAuth::Client.new(token: auth_token)
      user_store = client.user_store
      p user_store.getUser.username
    end

    def login
      print "What's your evernote sandbox account?"
      gets_account = gets.chomp()
      print "And the password?"
      gets_password = gets.chomp()
    
      begin
        auth_token = "S=s1:U=840c1:E=148e577e596:C=1418dc6b999:P=1cd:A=en-devtoken:V=2:H=f597a57e759dfaba5e319931fcad97a2"
        client = EvernoteOAuth::Client.new(token: auth_token, consumer_key:"mlc880926-8889", consumer_secret:"a298b6c359007305", sandbox: true)
        callback_url = "http://javaer.me"
        request_token = client.request_token(:oauth_callback => callback_url)
      
        agent = Mechanize.new
        page = agent.get(request_token.authorize_url)
       
        login_form = page.form('login_form')
        login_form.username = gets_account
        login_form.password = gets_password
        page = agent.submit(login_form, login_form.buttons.first)
       
        oauth_authorize_form = page.form('oauth_authorize_form')
        page = agent.submit(oauth_authorize_form, oauth_authorize_form.buttons.first)
      
        str = page.uri.to_s.split('oauth_verifier=')
        verfiy_code = str[1]
        final_token = request_token.get_access_token(:oauth_verifier => verfiy_code)
      
        customer_client = EvernoteOAuth::Client.new(token: final_token.token, consumer_key:"mlc880926-8889", consumer_secret:"a298b6c359007305", sandbox: true)
      
        note_store = customer_client.note_store
        notebooks = note_store.listNotebooks
        # puts "your note books list ......"
        # notebooks.each do |nb|
        #   puts nb.name
        # end
        File.open(Dir.home+"/.geeknote", 'w') { |file| file.write(final_token.token) }
        puts "awesome, you have login success"
      rescue => err
        puts "something wrong, maybe you got the wrong account or password"
      end
    end

  end
end
