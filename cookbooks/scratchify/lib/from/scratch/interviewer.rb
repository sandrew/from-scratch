require 'colorize'

module FromScratch
  module Interviewer
    class << self
      def greetings
        puts "Greetings, master! Let's make some magic.".blue
      end

      def get_host
        ask 'Please enter address of your server:', default: 'localhost'
      end

      private

      def ask(str, default: nil, default_str: nil, variants: [])
        puts
        puts str.yellow
        if variants.any?
          puts "[#{variants.map(&:yellow).join ' | '}]"
          while !variants.include?(answer = gets.strip)
            puts "not recognized".red
          end
          answer
        else
          if default || default_str
            puts "[#{default_str ? default_str : "leave blank for #{default.yellow}"}]"
          end
          answer = gets.strip
          default && answer.blank? ? default : answer
        end
      end
    end
  end
end
