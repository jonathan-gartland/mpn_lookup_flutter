package com.example.espresso_example;

import static androidx.test.espresso.flutter.EspressoFlutter.onFlutterWidget;
import static androidx.test.espresso.flutter.action.FlutterActions.click;
import static androidx.test.espresso.flutter.action.FlutterActions.syntheticClick;
import static androidx.test.espresso.flutter.assertion.FlutterAssertions.matches;
import static androidx.test.espresso.flutter.matcher.FlutterMatchers.isDescendantOf;
import static androidx.test.espresso.flutter.matcher.FlutterMatchers.withText;
import static androidx.test.espresso.flutter.matcher.FlutterMatchers.withTooltip;
import static androidx.test.espresso.flutter.matcher.FlutterMatchers.withType;
import static androidx.test.espresso.flutter.matcher.FlutterMatchers.withValueKey;
import static com.google.common.truth.Truth.assertThat;
import static org.junit.Assert.fail;

import androidx.test.core.app.ActivityScenario;
import androidx.test.espresso.flutter.EspressoFlutter.WidgetInteraction;
import androidx.test.espresso.flutter.assertion.FlutterAssertions;
import androidx.test.espresso.flutter.matcher.FlutterMatchers;
import androidx.test.ext.junit.runners.AndroidJUnit4;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import com.example.mpn_lookup_flutter.MainActivity;

/** Unit tests for {@link EspressoFlutter}. */
@RunWith(AndroidJUnit4.class)
public class MainActivityTest {

    @Before
    public void setUp() throws Exception {
        ActivityScenario.launch(MainActivity.class);
    }

    @Test
    public void performClick() {
        onFlutterWidget(withTooltip("About")).perform(click());
//        onFlutterWidget(withValueKey("CountText")).check(matches(withText("Button tapped 1 time.")));
    }
}
