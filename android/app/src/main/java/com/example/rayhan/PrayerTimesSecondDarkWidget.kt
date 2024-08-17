package com.example.rayhan

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import android.net.Uri

import es.antonborri.home_widget.HomeWidgetPlugin
import es.antonborri.home_widget.HomeWidgetLaunchIntent

/**
 * Implementation of App Widget functionality.
 */
class PrayerTimesSecondDarkWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            updateSecondDarkWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

internal fun updateSecondDarkWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {
    // Get reference to SharedPreferences
    val widgetData = HomeWidgetPlugin.getData(context)
    val views = RemoteViews(context.packageName, R.layout.prayer_times_second_dark_widget).apply {

        val pendingIntentWithData = HomeWidgetLaunchIntent.getActivity(
            context,
            MainActivity::class.java,
            Uri.parse("prayerTimes://message?message=logo"))
        setOnClickPendingIntent(R.id.logo_button, pendingIntentWithData)

        val refreshPendingIntent = HomeWidgetLaunchIntent.getActivity(
            context,
            MainActivity::class.java,
            Uri.parse("prayerTimes://message?message=refresh"))
        setOnClickPendingIntent(R.id.refresh_button, refreshPendingIntent)


        val fajr = widgetData.getString("fajr", null)
        setTextViewText(R.id.fajr_time, fajr ?: "")

        val sunrise = widgetData.getString("sunrise", null)
        setTextViewText(R.id.shurooq_time, sunrise ?: "")

        val dhuhr = widgetData.getString("dhuhr", null)
        setTextViewText(R.id.dhuhr_time, dhuhr ?: "")

        val asr = widgetData.getString("asr", null)
        setTextViewText(R.id.asr_time, asr ?: "")

        val maghrib = widgetData.getString("maghrib", null)
        setTextViewText(R.id.maghrib_time, maghrib ?: "")

        val isha = widgetData.getString("isha", null)
        setTextViewText(R.id.isha_time, isha ?: "")

        val subtitle = widgetData.getString("subtitle", null)
        setTextViewText(R.id.subtitle, subtitle ?: "")
    }

    // Instruct the widget manager to update the widget
    appWidgetManager.updateAppWidget(appWidgetId, views)
}