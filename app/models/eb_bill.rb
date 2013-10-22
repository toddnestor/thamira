class EbBill < ActiveRecord::Base
	belongs_to :user
	validates :service_name, :service_number, :mobile_number, :amount, :total, :bill_number, presence: true
	validates :amount, :total, numericality: {greater_than: 0}
	validates :bill_number, uniqueness: true
	before_create :set_bill_number
	def bill_number
		return super if self.persisted?
		last_bill_number = EbBill.today_bills.first.try(:bill_number)
		if last_bill_number.nil?
			bill_no = "#{Date.today.strftime("%y%m%d")}-0001"
		else
			bill_no = last_bill_number.next
		end
	end
	def self.today_bills(options={})
		user = options.delete(:user)
		if user
			where("DATE(created_at) = DATE(?) AND user_id = ?", Time.now, user.id).order("created_at desc")
		else
			where("DATE(created_at) = DATE(?)", Time.now).order("created_at desc")
		end
	end
	def self.last_10_bills
		order("created_at DESC").limit(10)
	end
	def self.bills_at(date)
		where("DATE(created_at) = DATE(?)", date).order("created_at asc")
	end
	private
		def set_bill_number
			self.bill_number = self.bill_number
		end
end