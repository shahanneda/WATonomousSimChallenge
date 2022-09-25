import rospy
from std_msgs.msg import String
from carla_msgs.msg import CarlaEgoVehicleControl
import carla

def talker():
    pub = rospy.Publisher('/carla/ego_vehicle/vehicle_control_cmd_manual',  CarlaEgoVehicleControl, queue_size=10)
            rospy.init_node('talker', anonymous=True)
                rate = rospy.Rate(10) # 10hz
                    #autop = rospy.Publisher(
                                #"/carla/{}/enable_autopilot".format("ego_vehice"), Bool, queue_size=1)

                                    cmd = CarlaEgoVehicleControl()
                                        cmd.throttle = -1

                                            while not rospy.is_shutdown():
                                                hello_str = "hello world %s" % rospy.get_time()
                                                                rospy.loginfo(cmd)
                                                                        pub.publish(cmd)
                                                                                rate.sleep()

                                                                                if __name__ == '__main__':
                                                                                    try:
                                                                                        talker()
                                                                                    except rospy.ROSInterruptException:
                                                                                        pass
                                                                                    2
