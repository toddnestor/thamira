class EbBill < ActiveRecord::Base
	validates :service_name, :service_number, :mobile_number, :amount, :total, :bill_number, presence: true
	validates :amount, :total, numericality: {greater_than: 0}
	validates :bill_number, uniqueness: true
	before_create :set_bill_number
	def bill_number
		return super if self.persisted?
		last_bill_number = EbBill.where("DATE(created_at) = DATE(?)", Time.now).order("created_at desc").first.try(:bill_number)
		if last_bill_number.nil?
			bill_no = "#{Date.today.strftime("%y%m%d")}-0001"
		else
			bill_no = last_bill_number.next
		end
	end
	private
		def set_bill_number
			self.bill_number = self.bill_number
		end
end