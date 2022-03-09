namespace Dino.Ui {

    public class SysTray {

        private StatusNotifier.Item sni;
        private Gtk.Widget mainwindow;

        public SysTray(Gtk.Widget mainwindow)
        {

            this.mainwindow = mainwindow;

            var category = StatusNotifier.Category.APPLICATION_STATUS;
            var status = StatusNotifier.Status.ACTIVE;
            var pixbuf = new Gdk.Pixbuf.from_file("./build/main/resources/icons/im.dino.Dino.png");

            sni = new StatusNotifier.Item.from_pixbuf("dino", category, pixbuf);
            
            sni.set_status(status);
            sni.main_icon_pixbuf = pixbuf;

            sni.set_title("Dino");
            /* sni.set_tooltip_title("Dino"); */
            /* sni.set_tooltip_body("Dino tooltip body"); */

            sni.activate.connect(make_menu);
            sni.context_menu.connect(make_menu);
            sni.secondary_activate.connect(make_menu);

            sni.registration_failed.connect((error) => {
                stderr.printf("Registration of StatusNotifierItem failed:\n");
                stderr.printf(error.message);
                stderr.printf("\n");
            });

            sni.register();

        }

        private bool make_menu(int x, int y)
        {
            var menu = new Gtk.Menu();
            Gtk.Widget widget;

            widget = new Gtk.MenuItem.with_label("Show");
            widget.button_press_event.connect(() => {
                mainwindow.show();
                return true;
            });
            widget.show();
            menu.attach(widget, 0, 1, 0, 1);

            widget = new Gtk.MenuItem.with_label("Quit");
            widget.button_press_event.connect(() => {
                Dino.Application.get_default().quit();
                return true;
            });
            widget.show();
            menu.attach(widget, 0, 1, 1, 2);

            menu.popup(null, null, null, 0, Gtk.get_current_event_time());

            return true;
        }

    }

}
