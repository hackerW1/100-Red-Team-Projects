#!/bin/env ruby

##########################
# Author:Sato Raiden     #
# Lang:Ruby              #
# License:GPL            #
##########################

require 'socket'

HOST = ARGV[0] || nil
PORT = ARGV[1] || nil
ENDPORT = ARGV[2] || nil

def usage_rem
    puts "Usage: ./portscanner.rb <host> <port>"
    puts "\t Example: ./portscanner.rb 192.168.2.11 443"
    puts "\nUsage: ./portscanner.rb <host> <start-port> <end-port>"
    puts "\t Example: ./portscanner.rb 192.168.2.11 443 1024"
end

if ENDPORT == nil
    if  PORT == nil || HOST == nil 
        usage_rem()
    else
        puts "[+] Scanning on #{HOST} for port #{PORT}"

        begin
            s = TCPSocket.new(HOST, PORT)
            puts "[+] Port #{PORT} is open on #{HOST}"
        rescue Errno::ECONNREFUSED
            puts "[-] #{PORT} is closed on #{HOST}"
        rescue SocketError
            puts "[-] Sad (T_T) can't connect to #{HOST}"
        rescue Errno::ETIMEDOUT
            puts "[-] Timed out sending request."
        rescue Interrupt
            puts "\nAbort!"
            exit
        end
    end
else
    PRTR = (PORT..ENDPORT)

    for prt in PRTR
        begin
            s = TCPSocket.new(HOST, prt)
            puts "[+] #{prt} is open"
        rescue Errno::ECONNREFUSED
            puts "[-] #{prt} is close"
        rescue SocketError
            puts "[-] Sad (T_T) can't connect to #{HOST}"
        rescue Errno::ETIMEDOUT
            puts "[-] Timed out sending request."
        rescue Interrupt
            puts "\nAbort!"
            exit
        end
    end
end