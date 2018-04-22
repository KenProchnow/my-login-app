class ExpensesController < ApplicationController
=begin

rails c
e = Expense.new
e.amount = 12.12
e.description = "this is a test expense"
e.transaction_date = "2017-01-01"

rails helper str to datetime
'06/15/2008'.to_date

=end

  before_action :authenticate_user!

  layout 'app_navigation'

  def index
    @expenses = Expense
                    .where(:user_id => current_user.id)
                    .order("transaction_date ASC")
    #now this where user_id must be done on EVERY query, doesn't seem safe.
    # Can i do this at a higher level, on every query automatically so a dev can't fuck this up.
    # what does devise normally do this for?

  end

  def show
    @expense = Expense
                   .where(:user_id => current_user.id)
                   .find(params[:id])
  end

  def create
    # replacing this with doing it manually so i have full control!
    # @expense = Expense.new(expense_params)

    expense = params[:expense]
    description = expense[:description]
    amount = expense[:amount]
    transaction_date = expense[:transaction_date]
    category = expense[:category]

    @expense = Expense.new
    @expense.description = description
    @expense.transaction_date = transaction_date
    @expense.amount = amount
    @expense.category = category.upcase
    @expense.user_id = current_user.id

    # for debugging
    # flash[:notice] = "the expense was created params: #{description} successfully"
    # redirect_to(:action => 'index')

    if @expense.save
      flash[:notice] = "the expense was created successfully #{current_user.id}" #{@expense.id}
      redirect_to(:action => 'index')
    else
      flash[:error] = "#{@expense.errors.full_messages.join(", ")}"
      render('new')
    end
  end

  def new
    @expense = current_user.expenses.new()
  end

  def edit
    @expense = Expense.where(:user_id => current_user.id).find(params[:id])
  end

  def update
    @expense = Expense.where(:user_id => current_user.id).find(params[:id])

    # uses mass assignment
    if @expense.update_attributes(expense_params)
      flash[:notice] = "the expense was updated successfully"
      redirect_to(:action => 'index', :id => @expense.id)
    else
      # when render gets called, it uses the current
      # state of @expense here, the instant variables
      # that are set in this controller.
      # and its sticky because of this.
      render('edit')
    end

  end

  def delete
    # since we are not using a template, we can assign to a local variable
    expense = Expense.where(:user_id => current_user.id).find(params[:id])
    if expense.destroy

      flash[:notice] = "the expense: #{expense.id} was destroyed successfully"
      redirect_to(:action => 'index')
    else
      render('index')
    end
  end

  private

  def expense_params
    # same as using "params[:page]", except that it
    # raises an error if :page is not present
    # allows listed attributes to be mass-assigned
    params.require(:expense).permit(:description,:amount,:transaction_date,:category)
  end
end
