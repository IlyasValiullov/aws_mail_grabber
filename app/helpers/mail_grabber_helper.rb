module MailGrabberHelper
  class MailGrabber

    def self.grab
      mails = Mail.all
      mails.each() do |mail|

        if mail.multipart?
          parse_multipart(mail)
        else
          body = JSON.parse(mail.decoded)
          message = JSON.parse(body.fetch("Message"))
          results = parse_message(message)
          save_message(results)
        end



      end
      true
    end

    def self.parse_message message


      results = {}
      results[:source] = message.to_json
      results[:email] = message["mail"]["destination"].first
      results[:message_type] = message["notificationType"]
      messageType = message["notificationType"]
      if messageType == "Bounce"


        results[:date] = DateTime.parse(message["bounce"]["timestamp"])
        results[:message_subtype] = message["bounce"]["bounceType"] + " " + message["bounce"]["bounceSubType"]
      elsif messageType == "Complaint"
        results[:date] = DateTime.parse(message["complaint"]["timestamp"])
        results[:message_subtype] = ""
      end

      results
    end

    def self.parse_multipart(message)
      clean_msg = message.parts[0].decoded.gsub("\n", "")
      msg_array = get_json_parts(clean_msg)
      msg_array.each { |msg|
        message = JSON.parse(msg)
        # puts parse_message(message)
        parsed = parse_message(message)
        save_message(parsed)
      }
      true
    end

    def self.save_message(results)
      Message.find_or_create_by(email: results[:email],
                                message_type: results[:message_type],
                                message_subtype: results[:message_subtype],
                                date: results[:date],
                                source: results[:source])

    end


    def self.get_json_parts(mes)
      parts = []

      mustaches_count = 0
      index_start = -1
      index_end = -1
      index = 0
      mes.each_char { |c|
        if c == '{'

          if mustaches_count == 0
            index_start = index
          end
          mustaches_count += 1
        end

        if c == '}'
          if mustaches_count == 1
            index_end = index
          end
          mustaches_count -= 1
        end

        if mustaches_count == 0 && index_start > 0 && index_end > 0
          parts.append(mes[index_start..index_end])
          index_start = -1
          index_end = -1
        end
        index += 1
      }

      return parts
    end

    private

    def check_mailbox

    end
    def check_and_create_messages

    end

  end
end
