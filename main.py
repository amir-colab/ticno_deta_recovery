from kivy.lang import Builder
from kivymd.app import MDApp
from kivy.uix.screenmanager import ScreenManager, Screen
from kivy.uix.filechooser import FileChooserIconView
from kivymd.toast import toast
from threading import Thread
import os
from libs.file_recovery import scan_deleted_files
from ads.adstera import AdsTerraBanner

class HomePage(Screen):
    pass

class RecoveryPage(Screen):
    def view_mode(self, mode):
        if mode == 'list':
            self.ids.file_list.viewclass = 'MDLabel'
        elif mode == 'grid':
            self.ids.file_list.viewclass = 'Image'

class FileScanningPage(Screen):
    scanning_thread = None
    is_scanning = False
    selected_save_path = None

    def show_file_chooser(self):
        filechooser = FileChooserIconView(path=os.path.expanduser("~"))
        filechooser.bind(on_submit=self.on_file_select)
        self.add_widget(filechooser)

    def on_file_select(self, chooser, selection, *args):
        if selection:
            self.selected_save_path = selection[0]
            self.ids.selected_path_label.text = f"Selected Path: {self.selected_save_path}"
            self.remove_widget(chooser)

    def start_scan(self):
        if not self.selected_save_path:
            toast("Please select a save path before starting the scan.")
            return
        if not os.path.isdir(self.selected_save_path):
            toast("Invalid path. Please select a valid directory.")
            return
        
        self.is_scanning = True
        self.scanning_thread = Thread(target=self.run_scan)
        self.scanning_thread.start()

    def run_scan(self):
        # Run pytsk3-based recovery
        try:
            files = scan_deleted_files("/dev/sda")  # Adjust this to your actual disk path
            for file in files:
                if not self.is_scanning:
                    break
                self.ids.file_list.data.append({'text': file})
                scanned_files = len(self.ids.file_list.data)
                self.ids.scanning_status.text = f"Files Scanned: {scanned_files}"
                self.ids.progress_bar.value = (scanned_files / len(files)) * 100
        except Exception as e:
            toast(f"Error: {e}")
            self.is_scanning = False

    def stop_scan(self):
        self.is_scanning = False
        if self.scanning_thread and self.scanning_thread.is_alive():
            self.scanning_thread.join()
        toast("Scanning Stopped.")

class TicnoApp(MDApp):
    def build(self):
        Builder.load_file('kv/main.kv')
        self.sm = ScreenManager()
        self.sm.add_widget(HomePage(name='home'))
        self.sm.add_widget(RecoveryPage(name='recovery'))
        self.sm.add_widget(FileScanningPage(name='scanning'))
        return self.sm

if __name__ == '__main__':
    TicnoApp().run()
