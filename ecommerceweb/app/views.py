from django.conf import settings
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.urls import reverse
from django.http import HttpResponse
from django.contrib import messages
from paypal.standard.forms import PayPalPaymentsForm
import uuid

from django.shortcuts import render,redirect,get_object_or_404
from django.views import View



from . models import Customer,Watch,Order,Cart
from .forms import SignupForm

from django.contrib.auth import authenticate,login,logout
from django.contrib.auth.forms import AuthenticationForm

from . forms import RegistrationForm,AuthenticateForm,ChangePasswordForm,UserProfileForm,AdminProfileForm,CustomerForm
from django.contrib.auth.forms import AuthenticationForm,PasswordChangeForm
from django.contrib.auth import authenticate,login,logout,update_session_auth_hash



#===============For Paypal =========================
# def payment(request):
#     host = request.get_host()

#     if request.method == 'POST':
#         selected_address_id = request.POST.get('selected_address')

#         if not selected_address_id:
#             return HttpResponse("Please select an address before proceeding to payment.", status=400)

#         paypal_dict = {
#             'business': settings.PAYPAL_RECEIVER_EMAIL,
#             'amount': '100.00',
#             'item_name': 'Order',
#             'invoice': str(uuid.uuid4()),
#             'currency_code': 'USD',
#             'notify_url': f"http://{host}{reverse('paypal-ipn')}",
#             'return_url': f"http://{host}{reverse('paymentsuccess', args=[selected_address_id])}",
#             'cancel_return': f"http://{host}{reverse('paymentcancel')}",
#         }

#         form = PayPalPaymentsForm(initial=paypal_dict)
#         return render(request, 'app/payment.html', {'paypal': form})  # matching the template

#     return render(request, 'select_address.html')

#=========================================================


# Create your views here.

def home(request):
    return render(request,'home.html')

def contact(request):
    return render(request,'contact.html')

def titan(request):
    return render(request,'titan.html')

def timex(request):
    return render(request,'timex.html')

def noice(request):
    return render(request,'noice.html')

def navy(request):
    return render(request,'navy.html')

def log_in(request):
    return render(request,'login.html')

def profile(request):
    return render(request,'profile.html')



#==========registration=================
    
def registration(request):
    if not request.user.is_authenticated:
        if request.method == 'POST':
            mf = RegistrationForm(request.POST)
            if mf.is_valid():
                mf.save()
                return redirect('login')    
        else:
            mf  = RegistrationForm()
        return render(request,'registration.html',{'mf':mf})
    else:
        return redirect('profile')

# ======================login===================
def log_in(request):
    if not request.user.is_authenticated: 
        if request.method == 'POST':       
            mf = AuthenticationForm(request,request.POST)
            if mf.is_valid():
                name = mf.cleaned_data['username']
                pas = mf.cleaned_data['password']
                user = authenticate(username=name, password=pas)
                if user is not None:
                    login(request, user)
                    return redirect('home')
        else:
            mf = AuthenticationForm()
        return render(request,'login.html',{'mf':mf})
    else:
        return redirect('/profile/')
# #=================profile==================
def profile(request):
    if request.user.is_authenticated:  # This check wheter user is login, if not it will redirect to login page
        return render(request,'profile.html',{'name':request.user})
    else:                                                # request.user returns the username
        return redirect('/login/')



#==================logout======================
def log_out(request):
    logout(request)
    return redirect('/login/')

#=============change password================

def changepassword(request):                                                  
    if request.user.is_authenticated:                              # Include old password 
        if request.method == 'POST':                               
            mf =ChangePasswordForm(request.user,request.POST)
            if mf.is_valid():
                mf.save()
                update_session_auth_hash(request,mf.user)
                return redirect('profile')
        else:
            mf = ChangePasswordForm(request.user)
        return render(request,'changepassword.html',{'mf':mf})
    else:
        return redirect('login')
    
#=============class based function=========================

class TitanCategoriesView(View):
    def get(self,request):
        watch_category = Watch.objects.filter(category='TITAN')  # we are using filter function of queryset, that will filter those data whose category belongs to dog
        return render(request,'titancategories.html',{'titan_category':watch_category})

class TimexCategoriesView(View):
    def get(self,request):
        watch_category = Watch.objects.filter(category='TIMEX')  
        return render(request,'timexcategories.html',{'titan_category':watch_category})

class NavyforceCategoriesView(View):
    def get(self,request):
        watch_category = Watch.objects.filter(category='NAVYFORCE') 
        return render(request,'navycategories.html',{'titan_category':watch_category})



class NoiseCategoriesView(View):
    def get(self,request):
        watch_category = Watch.objects.filter(category='NOISE') 
        return render(request,'noisecategories.html',{'noise_category':watch_category})


class WatchDetailView(View):
    def get(self,request,id):     # id = It will fetch id of particular watch 
        watch = Watch.objects.get(pk=id)

        #------ code for caculate percentage -----
        if watch.discounted_price !=0:    
            percentage = int(((watch.selling_price-watch.discounted_price)/watch.selling_price)*100)
        else:
            percentage = 0
        # ------ code end for caculate percentage ---------
            
        return render(request,'watch_details.html',{'watch':watch,'percentage':percentage})





#========add to cart==========================
# def add_to_cart(request, id): 
#     if request.user.is_authenticated:
#         product = Watch.objects.get(pk=id) 
#         user=request.user               
#         Cart(user=user,product=product).save() 
#         messages.success(request,'Added to cart succcefully !')
#         return redirect('watchdetails', id)       
#     else:
#         return redirect('login')    

def add_to_cart(request, id):
    if request.user.is_authenticated:
        watch = Watch.objects.get(pk = id)
        user = request.user
        cart_item = Cart.objects.filter(user=user, product=watch).first()
        if cart_item:
            cart_item.quantity += 1
            cart_item.save()
            messages.success(request, 'Quantity updated in cart!')
        else:
            Cart(user=user, product=watch).save()
            messages.success(request, 'Added to cart successfully!')
        return redirect('watchdetails', id)
    else:
        return redirect('login')


#================view cart================================
    
def view_cart(request):
    cart_items = Cart.objects.filter(user=request.user)     
    total =0
    delevery_charge =150
    for item in cart_items:
        item.product.price_and_quantity_total = item.product.selling_price * item.quantity
        total += item.product.price_and_quantity_total
    final_price= delevery_charge + total
    return render(request, 'view_cart.html', {'cart_items': cart_items,'total':total,'final_price':final_price})


#===========quantity manage=======================

def add_quantity(request, id):
    product = get_object_or_404(Cart, pk=id)    
    product.quantity += 1                       
    product.save()
    return redirect('viewcart')

def delete_quantity(request, id):
    product = get_object_or_404(Cart, pk=id)
    if product.quantity > 1:
        product.quantity -= 1
        product.save() 
    return redirect('viewcart')

def delete_cart(request,id):
    if request.method == 'POST':
        de = Cart.objects.get(pk=id)
        de.delete()
    return redirect('viewcart')


#---------------Addresh----------------------

def address(request):
    if request.method == 'POST':
            print(request.user)
            mf =CustomerForm(request.POST)
            print('mf',mf)
            if mf.is_valid():
                user=request.user               
                name= mf.cleaned_data['name']
                address= mf.cleaned_data['address']
                city= mf.cleaned_data['city']
                state= mf.cleaned_data['state']
                pincode= mf.cleaned_data['pincode']
                print(state)
                print(city)
                print(name)
                Customer(user=user,name=name,address=address,city=city,state=state,pincode=pincode).save()
                return redirect('address')           
    else:
        mf =CustomerForm()
        address = Customer.objects.filter(user=request.user)
    return render(request,'address.html',{'mf':mf,'address':address})


def delete_address(request,id):
    if request.method == 'POST':
        de = Customer.objects.get(pk=id)
        de.delete()
    return redirect('address')

#==========checkout==============
def checkout(request):
    cart_items = Cart.objects.filter(user=request.user)      
    total =0
    delevery_charge =150
    for item in cart_items:
        item.product.price_and_quantity_total = item.product.discounted_price * item.quantity
        total += item.product.price_and_quantity_total
    final_price= delevery_charge + total
    
    address = Customer.objects.filter(user=request.user)

    return render(request, 'checkout.html', {'cart_items': cart_items,'total':total,'final_price':final_price,'address':address})


#=========payment=========================
def payment(request): 
    selected_address_id = None  # ✅ Yeh line sabse important hai (yahi par likhna hai)

    if request.method == 'POST':
        selected_address_id = request.POST.get('selected_address')
        print('=========',selected_address_id)

    cart_items = Cart.objects.filter(user=request.user)
   

    total = 0
    delivery_charge = 150
    for item in cart_items:
        item.product.price_and_quantity_total = item.product.discounted_price * item.quantity
        total += item.product.price_and_quantity_total

    final_price = delivery_charge + total
    address = Customer.objects.filter(user=request.user)

    selected_address = None
    if selected_address_id:
        try:
            selected_address = Customer.objects.get(id=selected_address_id)
        except Customer.DoesNotExist:
            selected_address = None

    return render(request, 'payment.html', {
        'cart_items': cart_items,
        'total': total,
        'final_price': final_price,
        'address': address,
        'selected_address_id': selected_address_id,
        'selected_address': selected_address,
    })


#=============================== Paypal Code ===============================================
    host = request.get_host()

    paypal_checkout = {
        'business': settings.PAYPAL_RECEIVER_EMAIL,
        'amount': final_price,
        'item_name': 'Watch',
        'invoice': uuid.uuid4(),
        'currency_code': 'USD',
        'notify_url': f"http://{host}{reverse('paypal-ipn')}",
        'return_url': f"http://{host}{reverse('paymentsuccess', args=[selected_address_id])}",
        'cancel_url': f"http://{host}{reverse('paymentfailed')}",
    }

    paypal_payment = PayPalPaymentsForm(initial=paypal_checkout)

#==========================================================================================================
    return render(request, 'payment.html', {'cart_items': cart_items,'total':total,'final_price':final_price,'address':address,'paypal':paypal_payment})

#===================================== Payment Success ============================================

def payment_success(request,selected_address_id):  
    user =request.user
    customer_data = Customer.objects.get(pk=selected_address_id,)
    cart = Cart.objects.filter(user=user)
    for cart in cart:
        Order(user=user,customer=customer_data,Watch=cart.product,quantity=cart.quantity).save()
        cart.delete()
    return render(request,'payment_success.html')



#===================================== Payment Failed ============================================


def payment_failed(request):
    return render(request,'payment_failed.html')


#=========order=================

def order(request):
    ord=Order.objects.filter(user=request.user)
    return render(request,'order.html',{'ord':ord})



#========================================== Buy Now ========================================================
@login_required(login_url='login')
def buynow(request,id):
    watch = Watch.objects.get(pk=id) 
    delhivery_charge =250
    final_price= delhivery_charge + watch.discounted_price
    
    address = Customer.objects.filter(user=request.user)

    return render(request, 'buynow.html', {'final_price':final_price,'address':address,'watch':watch})


def buynow_payment(request,id):

    if request.method == 'POST':
        selected_address_id = request.POST.get('buynow_selected_address')

    watch = Watch.objects.get(pk=id)    
    delhivery_charge =150
    final_price= delhivery_charge + watch.discounted_price
    
    address = Customer.objects.filter(user=request.user)
    #================= Paypal Code ======================================

    host = request.get_host()   

    paypal_checkout = {
        'business': settings.PAYPAL_RECEIVER_EMAIL,
        'amount': final_price,
        'item_name': 'Watch',
        'invoice': uuid.uuid4(),
        'currency_code': 'USD',
        'notify_url': f"http://{host}{reverse('paypal-ipn')}",
        'return_url': f"http://{host}{reverse('buynowpaymentsuccess', args=[selected_address_id,id])}",
        'cancel_url': f"http://{host}{reverse('paymentfailed')}",
    }

    paypal_payment = PayPalPaymentsForm(initial=paypal_checkout)

    #========================================================================

    return render(request, 'payment.html', {'final_price':final_price,'address':address,'watch':watch,'paypal':paypal_payment})

def buynow_payment_success(request,selected_address_id,id):
    print('payment sucess',selected_address_id)   
    user =request.user
    customer_data = Customer.objects.get(pk=selected_address_id,)
    
    watch = Watch.objects.get(pk=id) 

    Order(user=user,customer=customer_data, Watch=watch, quantity=1).save()
   
    return render(request,'buynow_payment_success.html')