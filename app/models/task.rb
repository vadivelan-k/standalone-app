class Task < ActiveRecord::Base
  attr_accessible :name, :code, :cost, :cost_type, :taxable, :active
  
  belongs_to :firm, :inverse_of => :tasks
  has_many :time_entries, :inverse_of => :task
  
  def self.seed_tasks(firm)
    raise "Cannot seed firms that already have tasks" if firm.tasks.size > 0
    SEED_TASKS.each do |seed|
      firm.tasks.create(:code => seed[0], :name => seed[1], :active => true)
    end
  end
  
  validates :name,                :presence => true,
                                  :length => { :within => 1..255 }
  validates :code,                :presence => true,
                                  :length => { :within => 1..32 }

  SEED_TASKS = [
    ['A100','A100 - Activities'],
    ['A101','A101 - Plan and prepare for'],
    ['A102','A102 - Research'],
    ['A103','A103 - Draft / revise'],
    ['A104','A104 - Review / analyze'],
    ['A105','A105 - Communicate (in firm)'],
    ['A106','A106 - Communicate (with Client)'],
    ['A107','A107 - Communicate (other outside counsel)'],
    ['A108','A108 - Communicate (other external)'],
    ['A109','A109 - Appear for / attend'],
    ['A110','A110 - Copying'],
    ['A111','A111 - Other'],
    ['A112','A112 - Travel'],
    ['B410','B410 - General Bankruptcy Advice / Opinions'],
    ['C300','C300 - Analysis and Advice'],
    ['L100','L100 - Case Assessment, Development and Administration'],
    ['L110','L110 - Fact Investigation / Development'],
    ['L120','L120 - Analysis / Strategy'],
    ['L130','L130 - Experts / Consultants'],
    ['L140','L140 - Document / File Management'],
    ['L160','L160 - Settlement / Non-Binding ADR'],
    ['L200','L200 - Pre-Trial Pleadings and Motions'],
    ['L210','L210 - Pleadings'],
    ['L220','L220 - Preliminary Injunctions / Provisional Remedies'],
    ['L230','L230 - Court Mandated Conferences'],
    ['L240','L240 - Dispositive Motions'],
    ['L250','L250 - Other Written Motions and Submissions'],
    ['L300','L300 - Discovery'],
    ['L310','L310 - Written Discovery'],
    ['L320','L320 - Document Production'],
    ['L330','L330 - Depositions'],
    ['L340','L340 - Expert Discovery'],
    ['L350','L350 - Discovery Motions'],
    ['L390','L390 - Other Discovery'],
    ['L400','L400 - Trial Preparation and Trial'],
    ['L410','L410 - Fact Witnesses'],
    ['L420','L420 - Expert Witnesses'],
    ['L430','L430 - Written Motions and Submissions'],
    ['L440','L440 - Other Trial Preparation and Support'],
    ['L450','L450 - Trial and Hearing Attendance'],
    ['L460','L460 - Post-Trial Motions and Submissions'],
    ['L470','L470 - Enforcement'],
    ['L500','L500 - Appeal'],
    ['L510','L510 - Appellate Motions and Submissions'],
    ['L520','L520 - Appellate Briefs'],
    ['L530','L530 - Oral Argument'],
    ['P260','P260 - Intellectual Property']
  ]
end
# == Schema Information
#
# Table name: tasks
#
#  id         :integer(4)      not null, primary key
#  firm_id    :integer(4)
#  name       :string(255)     not null
#  code       :string(32)      not null
#  cost       :decimal(8, 2)   default(0.0), not null
#  cost_type  :integer(1)      default(0), not null
#  taxable    :boolean(1)      default(FALSE), not null
#  active     :boolean(1)      default(TRUE), not null
#  created_at :datetime
#  updated_at :datetime
#

