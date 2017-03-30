import React, { Component } from 'react';
import { AppRegistry, Text } from 'react-native';

class SimpleApp extends Component {
  render() {
    return (
      <Text>我是业务A RN 页面!</Text>
    );
  }
}
AppRegistry.registerComponent('SimpleApp', () => SimpleApp);
