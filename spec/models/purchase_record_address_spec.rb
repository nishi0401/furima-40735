require 'rails_helper'

RSpec.describe PurchaseRecordAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user_id: user.id)
    sleep(0.1)
    @purchase_record_address = FactoryBot.build(:purchase_record_address, user_id: user.id, item_id: item.id)
  end
  describe '購入情報の保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_record_address).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @purchase_record_address.building = ''
        expect(@purchase_record_address).to be_valid
      end
      it 'tokenがあれば保存ができること' do
        expect(@purchase_record_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postcodeが空だと保存できないこと' do
        @purchase_record_address.postcode = ''
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Postcode can't be blank", 'Postcode is invalid')
      end
      it 'postcodeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_record_address.postcode = '1231233'
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include('Postcode is invalid')
      end
      it 'postcodeが全角だと保存できないこと' do
        @purchase_record_address.postcode = '１２３‐１２３３'
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include('Postcode is invalid')
      end
      it 'prefecture_idを選択していないと保存できないこと' do
        @purchase_record_address.prefecture_id = ''
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @purchase_record_address.city = ''
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("City can't be blank")
      end
      it 'blockが空だと保存できないこと' do
        @purchase_record_address.block = ''
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Block can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @purchase_record_address.phone_number = ''
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Phone number can't be blank", 'Phone number is invalid')
      end
      it 'phone_numberにハイフンがあると保存できないこと' do
        @purchase_record_address.phone_number = '111-1111-1111'
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'phone_numberが全角だと保存できないこと' do
        @purchase_record_address.phone_number = '１１１１１１１１１１１'
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'user_idが紐付いていないと保存できないこと' do
        @purchase_record_address.user_id = nil
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが紐付いていないと保存できないこと' do
        @purchase_record_address.item_id = nil
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では登録できないこと' do
        @purchase_record_address.token = nil
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
