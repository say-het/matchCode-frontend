import { Stack } from "expo-router";
import { StatusBar } from "expo-status-bar";
import React from "react";

export default function RootLayout() {
  return (
    <>
      <Stack>
        <Stack.Screen
          name="screens/AuthScreen"          // <-- must match your file: app/AuthScreen.tsx
          options={{ headerShown: false }}
        />
        <Stack.Screen
          name="(tabs)"              // <-- must match your folder: app/(tabs)/_layout.tsx
          options={{ headerShown: false }}
        />
        <Stack.Screen
          name="+not-found"
          options={{ title: "Oops!" }}
        />
      </Stack>
      <StatusBar style="auto" />
    </>
  );
}
