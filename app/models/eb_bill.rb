class EbBill < ActiveRecord::Base
	belongs_to :user
	validates :service_name, :service_number, :mobile_number, :amount, :total, :bill_number, :user, presence: true
	validates :amount, :total, numericality: {greater_than_or_equal_to: 1}
	validates :bill_number, uniqueness: true
	before_validation :set_bill_number, :set_total

	def bill_number
		return super if self.persisted?
		last_bill_number = EbBill.today_bills.first.try(:bill_number)
		if last_bill_number.nil?
			bill_no = "A" + "#{Time.zone.now.strftime("%y%m%d")}-0001"
		else
			bill_no = last_bill_number.next
		end
	end
	def self.today_bills(options={})
		user = options.delete(:user)
		if user
			where("DATE(created_at) = DATE(?) AND user_id = ?", Time.zone.now, user.id).order("created_at desc")
		else
			where("DATE(created_at) = DATE(?)", Time.zone.now).order("created_at desc")
		end
	end
	def self.last_10_bills(options={})
		user = options.delete(:user)
		if user
			where(user: user).order('created_at DESC').limit(10)
		else
			order("created_at DESC").limit(10)
		end
	end
	def self.bills_at(date, options={})
		user = options.delete(:user)
		if user
			where("DATE(created_at) = DATE(?) AND user_id = ?", date, user.id).order("created_at asc")
		else
			where("DATE(created_at) = DATE(?)", date).order("created_at asc")
		end
	end

	private
	def set_bill_number
		self.bill_number = self.bill_number
	end
	def set_total
		self.total = self.amount + ((self.amount > 100) ? 10 : 5) if self.amount
	end
end