## ActiveRecord::Enum でprefix、suffixを付与する

prefix: trueやsuffix: trueを使用すると、enum名そのものが接頭辞や接尾辞として利用されるため、名前衝突を避けることができ、コードの可読性の向上が期待できる

https://api.rubyonrails.org/classes/ActiveRecord/Enum.html

```ruby
class Order < ApplicationRecord
 enum status: { pending: 0, processing: 1, completed: 2, canceled: 3 }, prefix: true
 enum payment_method: { credit_card: 0, bank_transfer: 1, paypal: 2 }, suffix: true
end

order = Order.new

order.status_pending!    # statusを:pendingに設定
order.status_processing! # statusを:processingに設定
order.status_completed!  # statusを:completedに設定
order.status_canceled!   # statusを:canceledに設定

order.status_pending?    # statusが:pendingかどうかをチェック
order.status_processing? # statusが:processingかどうかをチェック
order.status_completed?  # statusが:completedかどうかをチェック
order.status_canceled?   # statusが:canceledかどうかをチェック

order.credit_card_payment_method!    # payment_methodを:credit_cardに設定
order.bank_transfer_payment_method!  # payment_methodを:bank_transferに設定
order.paypal_payment_method!         # payment_methodを:paypalに設定

order.credit_card_payment_method?    # payment_methodが:credit_cardかどうかをチェック
order.bank_transfer_payment_method?  # payment_methodが:bank_transferかどうかをチェック
order.paypal_payment_method?         # payment_methodが:paypalかどうかをチェック
```
