module GeekNote
  class Client

    @@evernoteHost = "sandbox.evernote.com" #www.evernote.com for production

    def list_notebooks
      auth_token = "S=s1:U=840c1:E=148e577e596:C=1418dc6b999:P=1cd:A=en-devtoken:V=2:H=f597a57e759dfaba5e319931fcad97a2"
      client = EvernoteOAuth::Client.new(token: auth_token)
      note_store = client.note_store
      notebooks = note_store.listNotebooks
      puts "your note books list ......"
      notebooks.each do |nb|
        puts nb.name
      end
      # note = Evernote::EDAM::Type::Note.new
      # note.title = "hello from Codecademy"
      # note.content = '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd"><en-note>Hello Evernote<br/></en-note>'
      # note_store.createNote(note)
    end

    def list_tags
      auth_token = "S=s1:U=840c1:E=148e577e596:C=1418dc6b999:P=1cd:A=en-devtoken:V=2:H=f597a57e759dfaba5e319931fcad97a2"
      client = EvernoteOAuth::Client.new(token: auth_token)
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
      auth_token = "S=s1:U=840c1:E=148e577e596:C=1418dc6b999:P=1cd:A=en-devtoken:V=2:H=f597a57e759dfaba5e319931fcad97a2"
      # client = EvernoteOAuth::Client.new(token: auth_token)
      client = EvernoteOAuth::Client.new(token: auth_token, consumer_key:"mlc880926-8889", consumer_secret:"a298b6c359007305", sandbox: true)
      # user_store = client.user_store
      # begin
      #   ret = user_store.authenticate("malucheng","123456","mlc880926","6340835b50ea8641", false)
      # rescue
      #   p $!
      #   raise
      # end
      
      # callback_url = request.url.chomp("requesttoken").concat("callback")
      callback_url = "http://javaer.me"
      request_token = client.request_token(:oauth_callback => callback_url)
      # p request_token.authorize_url 
      agent = Mechanize.new
      page = agent.get(request_token.authorize_url)
      # p page
      login_form = page.form('login_form')
      login_form.username = 'malucheng'
      login_form.password = '123456'
      page = agent.submit(login_form, login_form.buttons.first)
      # pp page
      oauth_authorize_form = page.form('oauth_authorize_form')
      page = agent.submit(oauth_authorize_form, oauth_authorize_form.buttons.first)
      # pp page
      #error: 500 => Net::HTTPInternalServerError for http://localhost:4567/callback?oauth_token=mlc880926-8889.141D5AD4543.687474703A2F2F6C6F63616C686F73743A343536372F63616C6C6261636B.7F47659E2B6ED8BD81E8EE92998BA022&oauth_verifier=E5AC772F8563D3B644F0A990F9EF3FCF -- unhandled response
      # url = URI.parse(page.uri)
      # query = url.to_s
      pp page.uri.to_s
      str = page.uri.to_s.split('oauth_verifier=')
      verfiy_code = str[1]
      final_token = request_token.get_access_token(:oauth_verifier => verfiy_code)
      p final_token
      customer_client = EvernoteOAuth::Client.new(token: final_token.token, consumer_key:"mlc880926-8889", consumer_secret:"a298b6c359007305", sandbox: true)
      p "----------"
      note_store = customer_client.note_store
      notebooks = note_store.listNotebooks
      puts "your note books list ......"
      notebooks.each do |nb|
        puts nb.name
      end
    end
  end
end
