#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'csv'
require 'braintree'
require 'pony'

#establishing viewing routes
get '/' do
  erb :dashboard
end

get '/success' do
  erb :success
end

get '/failure' do
  erb :failure
end

#execute refund
post '/' do
# environment params
  merchant_name = params[:merchant_name]
  merchant_id = params[:merchant_id]
  public_key = params[:public_key]
  private_key = params[:private_key]
  environment = params[:environment]

  if environment == "sandbox"
    gateway = Braintree::Gateway.new(
      :environment => :sandbox,
      :merchant_id => "#{merchant_id}",
      :public_key => "#{public_key}",
      :private_key => "#{private_key}",
  )
  elsif environment == "production"
    gateway = Braintree::Gateway.new(
      :environment => :production,
      :merchant_id => "#{merchant_id}",
      :public_key => "#{public_key}",
      :private_key => "#{private_key}",
    )
  end

# open file and feed transaction IDs into an array
  if params[:attachment] && params[:attachment][:filename]
    filename = params[:attachment][:filename]
    file = params[:attachment][:tempfile]
    path = "./public/uploads/#{filename}"

    File.open(path, 'wb') do |f|
      f.write(file.read)
    end

    transaction_list = []

    CSV.foreach("#{path}") do |row|
      transaction_list << row[0]
    end    
  end

  print "this might be where a loop error is 1"

  refund_list = []
  x = 1
  while x < transaction_list.length
    result = gateway.transaction.refund("#{transaction_list[x]}")

    if result.success? == "true"
      refund_list << [result.transaction.created_at,result.transaction.refunded_transaction_id,result.transaction.id,result.transaction.amount.truncate(2).to_s('F'),"Refund was successful"]
    else 
      refund_list << [result.transaction.created_at,result.transaction.refunded_transaction_id,result.transaction.id,result.transaction.amount.truncate(2).to_s('F'),result.message]
    end
    
    x += 1
  end

  print "this might be where a loop error is 2"

#create a log file 
  headers = ["Time Initiated","OriginalTransactionID","RefundTransactionID","Amount","Status"]
  current_time = Time.now.utc
  CSV.open("./public/results/#{merchant_id}_#{current_time}.csv.log","w") do |csv|
    csv << headers
    refund_list.each do |item|
      csv << item
    end
  end 

  Pony.mail({
    :to => 'travellwilliams11@gmail.com',
    :from => 'travellwilliams11@gmail.com',
    :subject => "Bulk Refund Complete: #{merchant_name} ",
    :body => "Hi there!\n The bulk refund you requested has been processed. Please see the log file attached to this email.\nSincerely,\nThe Reseter",
    :attachments => {"#{merchant_id}_#{current_time}.csv.log" => File.read("./public/results/#{merchant_id}_#{current_time}.csv.log")}
  })

  redirect "/success"

 
end