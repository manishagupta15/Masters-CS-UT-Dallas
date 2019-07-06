
import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;

import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

import java.util.HashMap;

public class Part1 {
	
	public static class Map extends Mapper<LongWritable,Text,Text,Text>
	{
	
		String pair="";
	
		public void map(LongWritable key, Text value,Context context) throws IOException, InterruptedException
		{
			String[] line = value.toString().split("\t");
			if(line.length==2)
			{
				int personA = Integer.parseInt(line[0]);
				String[] friends =line[1].split(",");
				for(String friend:friends)
				{
				
					int personB=Integer.parseInt(friend);
					if(personA <= personB)
					{
						pair=personA + "," + personB;
					}
					else
					{
						pair=personB + "," + personA;
					}
					context.write(new Text(pair), new Text(line[1]));
				
				
				}
			}
		}
	}
	
	
	public static class Reduce extends Reducer<Text,Text,Text,Text>
	{
		
		private Text result = new Text();
		
		public void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException
		{
			HashMap<String, Integer> map=new HashMap<String, Integer>();
			StringBuilder mutualFriends=new StringBuilder();
			for(Text value : values)
			{
				String[] friends=value.toString().split(",");
				for(String friend : friends)
				{
					if(map.containsKey(friend))
					{
						mutualFriends.append(friend + ',');
					}
					else
					{
						map.put(friend,1);
					}
				}
			}
			
			if (mutualFriends.lastIndexOf(",") > -1)
			{
				
				mutualFriends.deleteCharAt(mutualFriends.lastIndexOf(","));
			}
			result.set(new Text(mutualFriends.toString()));
			context.write(key, result);
		}
		
	}
	
	public static void main(String args[]) throws Exception
	{
		Configuration conf=new Configuration();
		String[] otherargs=new GenericOptionsParser(conf,args).getRemainingArgs();
		
		Job job = Job.getInstance(conf,"Mutual Friends");
		job.setJarByClass(Part1.class);
		job.setMapperClass(Map.class);
		
		job.setReducerClass(Reduce.class);
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(Text.class);
		FileInputFormat.addInputPath(job,new Path(otherargs[0]));
		FileOutputFormat.setOutputPath(job, new Path(otherargs[1]));
		System.exit(job.waitForCompletion(true) ? 0:1);
	}
}

