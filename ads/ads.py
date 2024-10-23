# ads.py

class AdMobManager:
    def __init__(self, app_id, ad_unit_id):
        self.app_id = app_id
        self.ad_unit_id = ad_unit_id
        self.initialize_ads()

    def initialize_ads(self):
        # AdMob initialize karne ka function
        print(f"AdMob initialized with App ID: {self.app_id}")

    def show_banner_ad(self):
        # Banner ad dikhane ka function
        print(f"Banner Ad shown with Unit ID: {self.ad_unit_id}")

    def show_interstitial_ad(self):
        # Interstitial ad dikhane ka function
        print(f"Interstitial Ad shown with Unit ID: {self.ad_unit_id}")
      
